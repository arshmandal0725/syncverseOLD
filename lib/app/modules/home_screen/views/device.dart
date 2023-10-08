import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

var rji = null;

class ChartData {
  late String x;
  late double y1;

  ChartData(this.x, this.y1);
}

final List<ChartData> chartData = [
  ChartData('Gas', 74),
  ChartData('Humidity', 71.1),
  ChartData('Temperature', 31.30),
];

class Device extends StatefulWidget {
  const Device({Key? key}) : super(key: key);

  @override
  State<Device> createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  final ref = FirebaseDatabase.instance.reference().child('test');

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _getData().then((_) {
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      print('Error loading data: $error');
      setState(() {
        isLoading = false;
      });
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title ?? '',
          notification.body ?? '',
          NotificationDetails(
            android: AndroidNotificationDetails(
              'channel_id',
              'channel_name',
              channelDescription: 'channel_description',
              color: Colors.blue,
              importance: Importance.high,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      showDialog(
        context: context,
        builder: (_) {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (notification != null && android != null) {
            return AlertDialog(
              title: Text(notification.title ?? ''),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.body ?? ''),
                  ],
                ),
              ),
            );
          }
          return AlertDialog(
            title: Text('Unknown Notification'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Unknown notification body'),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Future<void> _getData() async {
    final snapshot = await ref.once();
    // Handle the data snapshot here
  }

  void showNotification(String title, String subtitle) {
    print("I'm working");
    FlutterLocalNotificationsPlugin().show(
      0,
      title,
      subtitle,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channel_description',
          color: Colors.blue,
          playSound: true,
          importance: Importance.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  Widget showingData(String title, String subtitle, String sign) {
    return Text(
      '$title: $subtitle $sign',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Linked Device Data'),
      ),
      body: Column(
        children: [
          //Chart Area
          Container(
            height: MediaQuery.of(context).size.height * 0.24,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                StackedColumnSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData ch, _) => ch.x,
                  yValueMapper: (ChartData ch, _) => ch.y1,
                ),
              ],
            ),
          ),
          Text("These all are average values"),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            'Real Time Data of Your Device',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Expanded(
            child: Container(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : FirebaseAnimatedList(
                      query: ref,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        final data = snapshot.value;
                        final dataKey = snapshot.key;
                        var gasData;
                        var gasTemp;
                        if (dataKey == 'gas') {
                          gasData = double.parse(data.toString()).toDouble();

                          chartData.add(ChartData('Gas', 50));
                        }
                        if (dataKey == 'temperature') {
                          gasTemp = double.parse(data.toString()).toDouble();
                        }
                        if (dataKey == 'gas' && (gasData) >= 200.0) {
                          showNotification(
                              '🛑Gas Leaked !!!🛑', '🔥🔥Fire In Hotel🔥🔥');
                        }
                        if (dataKey == 'temperature' && (gasTemp) >= 80.0) {
                          showNotification('🛑Temperature High !!!🛑',
                              '🔥🔥Fire In Hotel🔥🔥');
                        }

                        if (data != null) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.deepPurple,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ListTile(
                              shape: Border.all(color: Colors.white, width: 0),
                              tileColor: Colors.deepPurple,
                              horizontalTitleGap: 100,
                              title: (() {
                                if (dataKey == 'gas') {
                                  return showingData(dataKey.toString(),
                                      data.toString(), 'ppm');
                                } else if (dataKey == 'humidity') {
                                  return showingData(
                                      dataKey.toString(), data.toString(), '%');
                                } else if (dataKey == 'temperature') {
                                  return showingData(dataKey.toString(),
                                      data.toString(), '°C');
                                } else {
                                  return showingData(
                                      dataKey.toString(), data.toString(), '');
                                }
                              })(),
                            ),
                          );
                        }

                        return ListTile(
                          title: Text('Invalid data format'),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
