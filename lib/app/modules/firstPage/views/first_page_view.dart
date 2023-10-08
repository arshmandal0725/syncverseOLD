import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:syncverse/app/modules/helpcontact/views/helpcontact_view.dart';
import 'package:syncverse/app/modules/wifi_connection.dart/wifi_list.dart';
import './sensor_data.dart';
import 'package:http/http.dart' as http;

class FirstPageView extends StatefulWidget {
  const FirstPageView({super.key});

  @override
  State<FirstPageView> createState() => _FirstPageViewState();
}

List<List<RoomData>> roomData = [];

class _FirstPageViewState extends State<FirstPageView> {
  final ref = FirebaseDatabase.instance.reference().child('test');
  var isOnOf = false;
  var status = false;
  bool onOf = false;
  bool tipTap = false;
  List<bool> boolList = [false, true, false]; //
  int selectedRoomIndex = -1;
  var currentIndex = 0;
  List<RoomData> roomList = [];

  Future<List<RoomData>> fetchDataFromFirebase() async {
    //fetching data from firebase
    final url = Uri.https(
        "sync-verse-4a6e2-default-rtdb.firebaseio.com", "Details.json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      //List<RoomData> roomList = [];

      data?.forEach((key, value) {
        print("this is key");
        print(key);
        final roomNo = value['Room_no'];
        final icon = value['icon'];
        final imageUrl = value['image_url'];
        final onOf = value['isSwitchOn'];
        final deviceName = value['device_Name'];

        RoomData roomData = RoomData(
          roomNo: (roomNo != null) ? roomNo : '',
          icon: icon,
          imageUrl: imageUrl,
          onOf: (onOf != null) ? onOf : false,
          deviceName: deviceName,
          Key: key,
        );

        // Add the room data to the list
        roomList.add(roomData);
      });

      return roomList;
    } else {
      print('Failed to fetch data from Firebase.');
      return []; // return an empty list in case of error
    }
  }

  Future<void> updateRoomSwitchState(String roomId, bool newValue) async {
    try {
      final url = Uri.https("sync-verse-4a6e2-default-rtdb.firebaseio.com",
          "Details/$roomId.json");

      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({'isSwitchOn': newValue}),
      );

      if (response.statusCode != 200) {
        print(
            'Failed to update isSwitchOn in Firebase: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error updating isSwitchOn variable: $error');
    }
  }

  //code to write delete the element

  Future<void> deleteDataFromFirebase(String key) async {
    print("this is the delete key");
    print(key);
    final url = Uri.https(
        "sync-verse-4a6e2-default-rtdb.firebaseio.com", "Details/$key.json");

    final response = await http.delete(url);
    setState(() {
      roomList.removeWhere((element) => element.Key == key);
    });

    if (response.statusCode == 200) {
      print('Data deleted successfully.');
    } else {
      print('Failed to delete data from Firebase.');
    }
  }

  bool isEmergencyNavigating = false;

  void emergency() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => HelpcontactView()));
    });
  }

  void showNotification(String title, String subtitle) {
    print("I'm working");
    // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> HelpCon);

    FlutterLocalNotificationsPlugin().show(
      0,
      title,
      subtitle,
      const NotificationDetails(
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

  Map<int, List<Color>> selectedGradientColors = {};
  List<Color> color1 = const [
    Color.fromARGB(255, 181, 236, 242),
    Color.fromRGBO(1, 202, 210, 1)
  ];
  List<Color> color2 = const [
    Color.fromRGBO(168, 141, 214, 1),
    Color.fromRGBO(110, 62, 190, 1)
  ];
  List<Color> color3 = const [
    Color.fromRGBO(189, 110, 193, 1),
    Color.fromRGBO(190, 62, 169, 1)
  ];
  List<Color> color4 = const [
    Colors.white,
    Color.fromARGB(255, 230, 245, 247),
  ];
  List<Color> color5 = const [
    Colors.red,
    Color.fromARGB(255, 247, 230, 247),
  ];
  var temp;
  var humid;
  var gas;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: roomData.length + 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(231, 238, 250, 1),
          foregroundColor: Colors.black,
          title: Image.asset(
            'assets/SV.png',
            height: 20,
          ),
          leading: IconButton(
              onPressed: () {
                print('drawer');
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu_sharp)),
          bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: const Color(0xFF152D5E)),
              indicatorColor: const Color.fromRGBO(231, 238, 250, 1),
              automaticIndicatorColorAdjustment: false,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              tabs: List.generate(roomData.length + 1, (index) {
                if (index == 0) {
                  return const SizedBox(
                    height: 40,
                    width: 100,
                    child: Center(
                        child: Text(
                      "All Devices",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )),
                  );
                } else {
                  return SizedBox(
                    height: 40,
                    width: 100,
                    child: Center(
                        child: Text(
                      "Room $index",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    )),
                  );
                }
              })),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  size: 30,
                )),
            IconButton(
                onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const WifiList();
                    })),
                icon: const Icon(
                  Icons.wifi,
                  size: 30,
                )),
          ],
        ),
        body: StreamBuilder(
            stream: ref.onValue,
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData && snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              }
              dynamic snapshotValue = snapshot.data!.snapshot.value;
              SensorData? sensorData;
              if (snapshotValue is Map<dynamic, dynamic>) {
                Map<dynamic, dynamic> values = snapshotValue;
                sensorData = SensorData.fromSnapshot(values);
                // Now you can safely work with 'values'
                // ...
              } else {
                // Handle the case where 'snapshotValue' is not a Map<dynamic, dynamic>
                // This may occur if the data retrieved doesn't match your expectations
                // ...
              }
              if (sensorData != null) {
                if (sensorData!.gas != null &&
                    double.parse(sensorData.gas) >= 300) {
                  showNotification(
                      '🛑Gas Leaked !!!🛑', '🔥🔥Fire In Hotel🔥🔥');

                  emergency();
                }
              }

              return Stack(
                children: [
                  Container(
                    color: Color.fromRGBO(231, 238, 250, 1),
                  ),
                  TabBarView(
                      children: List.generate(roomData.length + 1, (index) {
                    if (index == 0) {
                      return Center(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: MediaQuery.of(context).size.height * 0.27,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                          children: [
                                            SizedBox(
                                                height: 83,
                                                width: 165,
                                                child: Card(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          25))),
                                                  color: const Color.fromRGBO(
                                                      214, 176, 180, 1),
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 2),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child:
                                                          (sensorData != null)
                                                              ? Text(
                                                                  "${sensorData.Temperature}",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                )
                                                              : const Text(
                                                                  "0",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                )),
                                                )),
                                            const SizedBox(
                                              height: 83,
                                              width: 120,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25))),
                                                color: Color.fromRGBO(
                                                    158, 76, 85, 0.9),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "Temperature",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                    Text(
                                                      "|",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            SizedBox(
                                                height: 83,
                                                width: 165,
                                                child: Card(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          25))),
                                                  color: const Color.fromRGBO(
                                                      177, 198, 242, 1),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: (sensorData != null)
                                                        ? Text(
                                                            sensorData.gas,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )
                                                        : const Text(
                                                            '0',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                  ),
                                                )),
                                            const SizedBox(
                                              height: 83,
                                              width: 120,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25))),
                                                color: Color.fromRGBO(
                                                    95, 139, 228, 1),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "Gas",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                    Text(
                                                      "|",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                          children: [
                                            SizedBox(
                                              height: 83,
                                              width: 165,
                                              child: Card(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                                color: const Color.fromRGBO(
                                                    214, 176, 180, 1),
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(right: 2),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: (sensorData != null)
                                                      ? Text(
                                                          sensorData.Humidity,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      : const Text(
                                                          '0',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 83,
                                              width: 120,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25))),
                                                color: Color.fromRGBO(
                                                    158, 76, 85, 0.9),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "Humidity",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                    Text(
                                                      "|",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            SizedBox(
                                              height: 83,
                                              width: 165,
                                              child: Card(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                                color: const Color.fromRGBO(
                                                    177, 198, 242, 1),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: const Text(
                                                    "60",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 83,
                                              width: 120,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25))),
                                                color: Color.fromRGBO(
                                                    95, 139, 228, 1),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "Temperature",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                    Text(
                                                      "|",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            SizedBox(
                              //the below one grid view
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 1,
                              child: FutureBuilder<List<RoomData>>(
                                  future: fetchDataFromFirebase(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<RoomData>> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // Handle the loading state
                                      return const Center(
                                        child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator()),
                                      );
                                    } else if (snapshot.hasError) {
                                      // Handle the error state
                                      return Column(
                                        children: [
                                          Container(
                                              height: 90,
                                              width: 50,
                                              child:
                                                  const CircularProgressIndicator(
                                                color: Colors.greenAccent,
                                              )),
                                          const Center(
                                              child: Text(
                                            "No devices is adaded yet , please choose a subscription",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 158, 216, 243),
                                                fontStyle: FontStyle.italic),
                                          )),
                                        ],
                                      ); //"Error: ${snapshot.error}"
                                    } else {
                                      List<RoomData> roomList = snapshot.data!;
                                      List<bool> boolList = List.generate(
                                          roomList.length, (index) => false);
                                      print("its been taking time");
                                      print(boolList);
                                      return GridView.count(
                                        crossAxisCount: 2,
                                        children: roomList
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          int index = entry.key;
                                          var catData = entry.value;

                                          return StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter setState) {
                                            return Card(
                                              elevation: 10,
                                              margin: const EdgeInsets.all(10),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25)),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(25)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: boolList[index]
                                                          ? (selectedGradientColors[
                                                                  index] ??
                                                              (index % 3 == 1
                                                                  ? color1
                                                                  : index % 3 ==
                                                                          2
                                                                      ? color2
                                                                      : color3))
                                                          : color4, //color4

                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.wifi),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 15),
                                                            height: 30,
                                                            width: 30,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    7),
                                                              ),
                                                              child: Image(
                                                                image: AssetImage(
                                                                    catData
                                                                        .imageUrl),
                                                                height: 10,
                                                                width: 10,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      ListTile(
                                                        title: Text(
                                                          catData.deviceName,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                            "Room No. ${catData.roomNo}"),
                                                      ),
                                                      const Divider(
                                                        thickness: 1,
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.04729,
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Switch(
                                                                    //switch to on and of
                                                                    onChanged: (bool
                                                                        value) async {
                                                                      setState(
                                                                          () {
                                                                        boolList[index] =
                                                                            value;
                                                                        if (value) {
                                                                          selectedGradientColors[
                                                                              index] = index % 3 ==
                                                                                  1
                                                                              ? color1
                                                                              : index % 3 == 2
                                                                                  ? color2
                                                                                  : color3;
                                                                        } else {
                                                                          selectedGradientColors
                                                                              .remove(index);
                                                                        }
                                                                      });
                                                                      await updateRoomSwitchState(
                                                                          catData
                                                                              .Key,
                                                                          value);
                                                                      print(boolList[
                                                                          index]);
                                                                    },
                                                                    value: boolList[
                                                                        index],
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            15),
                                                                    child: Text(
                                                                      boolList[
                                                                              index]
                                                                          ? "ON"
                                                                          : "OFF",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () async {
                                                                      try {
                                                                        await deleteDataFromFirebase(
                                                                            catData.Key); // Assuming you have a way to get the room ID
                                                                        // Handle successful deletion
                                                                      } catch (error) {
                                                                        // Handle error
                                                                      }
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .delete),
                                                                  ),
                                                                ],
                                                              ),
                                                              //},
                                                              //),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        }).toList(),
                                      );
                                    }
                                  }),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: MediaQuery.of(context).size.height * 0.27,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                          children: [
                                            SizedBox(
                                                height: 83,
                                                width: 165,
                                                child: Card(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          25))),
                                                  color: const Color.fromRGBO(
                                                      214, 176, 180, 1),
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 2),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child:
                                                          (sensorData != null)
                                                              ? Text(
                                                                  "${sensorData.Temperature}",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                )
                                                              : const Text(
                                                                  "0",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                )),
                                                )),
                                            const SizedBox(
                                              height: 83,
                                              width: 120,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25))),
                                                color: Color.fromRGBO(
                                                    158, 76, 85, 0.9),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "Temperature",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                    Text(
                                                      "|",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            SizedBox(
                                                height: 83,
                                                width: 165,
                                                child: Card(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          25))),
                                                  color: const Color.fromRGBO(
                                                      177, 198, 242, 1),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: (sensorData != null)
                                                        ? Text(
                                                            sensorData.gas,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )
                                                        : const Text(
                                                            '0',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                  ),
                                                )),
                                            const SizedBox(
                                              height: 83,
                                              width: 120,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25))),
                                                color: Color.fromRGBO(
                                                    95, 139, 228, 1),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "Gas",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                    Text(
                                                      "|",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                          children: [
                                            SizedBox(
                                              height: 83,
                                              width: 165,
                                              child: Card(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                                color: const Color.fromRGBO(
                                                    214, 176, 180, 1),
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(right: 2),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: (sensorData != null)
                                                      ? Text(
                                                          sensorData.Humidity,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      : const Text(
                                                          '0',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 83,
                                              width: 120,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25))),
                                                color: Color.fromRGBO(
                                                    158, 76, 85, 0.9),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "Humidity",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                    Text(
                                                      "|",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            SizedBox(
                                              height: 83,
                                              width: 165,
                                              child: Card(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                                color: const Color.fromRGBO(
                                                    177, 198, 242, 1),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: const Text(
                                                    "60",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 83,
                                              width: 120,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25))),
                                                color: Color.fromRGBO(
                                                    95, 139, 228, 1),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                      "Temperature",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                    Text(
                                                      "|",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            SizedBox(
                              //the below one grid view
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 1,
                              child: FutureBuilder<List<RoomData>>(
                                  future: fetchDataFromFirebase(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<RoomData>> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // Handle the loading state
                                      return const Center(
                                        child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircularProgressIndicator()),
                                      );
                                    } else if (snapshot.hasError) {
                                      // Handle the error state
                                      return Column(
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              child:
                                                  const CircularProgressIndicator(
                                                color: Colors.greenAccent,
                                              )),
                                          const Center(
                                              child: Text(
                                            "No devices is adaded yet , please choose a subscription",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 158, 216, 243),
                                                fontStyle: FontStyle.italic),
                                          )),
                                        ],
                                      ); //"Error: ${snapshot.error}"
                                    } else {
                                      List<RoomData> roomList = snapshot.data!;
                                      return GridView.count(
                                        crossAxisCount: 2,
                                        children: roomList
                                            .where((RoomData) =>
                                                RoomData.roomNo == "1")
                                            .toList()
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          int index = entry.key;
                                          var e = entry.value;

                                          return GestureDetector(
                                            onLongPress: () {
                                              deleteDataFromFirebase(e.Key);
                                            },
                                            child: StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter setState) {
                                              return Card(
                                                elevation: 10,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(25)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: boolList[index]
                                                            ? (selectedGradientColors[
                                                                    index] ??
                                                                (index % 3 == 1
                                                                    ? color1
                                                                    : index % 3 ==
                                                                            2
                                                                        ? color2
                                                                        : color3))
                                                            : color4, //color4

                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {},
                                                              icon: const Icon(
                                                                  Icons.wifi),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          15),
                                                              height: 30,
                                                              width: 30,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          7),
                                                                ),
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      e.imageUrl),
                                                                  height: 10,
                                                                  width: 10,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        ListTile(
                                                          title: Text(
                                                            e.deviceName,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                              "Room No. ${e.roomNo}"),
                                                        ),
                                                        const Divider(
                                                          thickness: 1,
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.056,
                                                          child: SizedBox(
                                                            height: 50,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Switch(
                                                                      //switch to on and of
                                                                      onChanged:
                                                                          (bool
                                                                              value) async {
                                                                        setState(
                                                                            () {
                                                                          boolList[index] =
                                                                              value;
                                                                          if (value) {
                                                                            selectedGradientColors[index] = index % 3 == 1
                                                                                ? color1
                                                                                : index % 3 == 2
                                                                                    ? color2
                                                                                    : color3;
                                                                          } else {
                                                                            selectedGradientColors.remove(index);
                                                                          }
                                                                        });
                                                                        await updateRoomSwitchState(
                                                                            e.Key,
                                                                            value);
                                                                        print(boolList[
                                                                            index]);
                                                                      },
                                                                      value: boolList[
                                                                          index],
                                                                    ),
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              15),
                                                                      child:
                                                                          Text(
                                                                        boolList[index]
                                                                            ? "ON"
                                                                            : "OFF",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          fontSize:
                                                                              18,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        try {
                                                                          await deleteDataFromFirebase(
                                                                              e.Key); // Assuming you have a way to get the room ID
                                                                          // Handle successful deletion
                                                                        } catch (error) {
                                                                          // Handle error
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .delete),
                                                                    ),
                                                                  ],
                                                                ),
                                                                //},
                                                                //),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        }).toList(),
                                      );
                                    }
                                  }),
                            ),
                          ],
                        ),
                      );
                    }
                  })),
                ],
              );
            }),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String
      label; //here by making a string variable we are updating the label of tabbar dynamically

  final indexx;

  const RepeatedTab({
    super.key,
    required this.label,
    required this.indexx,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: SizedBox(
          width: 100,
          child: Center(
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ),
      ),
    );
  }
}

class publicDetails {
  String roomNo, equipment, imageLink;
  final IconData icon;
  var temp;
  var sname = "";

  var isOnOf = false;

  publicDetails({
    required this.roomNo,
    required this.equipment,
    required this.icon,
    required this.imageLink,
    required this.isOnOf,
    required this.temp,
    required this.sname,
  });
}

class RoomData {
  final String roomNo;
  final String icon;
  final String imageUrl;
  late final bool onOf;
  final String deviceName;
  var Key;

  RoomData({
    required this.roomNo,
    required this.icon,
    required this.imageUrl,
    required this.onOf,
    required this.deviceName,
    required this.Key,
  });
}


/*import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:syncverse/app/modules/helpcontact/views/helpcontact_view.dart';
import '../../profile/views/profile_view.dart';
import './sensor_data.dart';
import 'package:http/http.dart' as http;

class FirstPageView extends StatefulWidget {
  const FirstPageView({super.key});

  @override
  State<FirstPageView> createState() => _FirstPageViewState();
}

class _FirstPageViewState extends State<FirstPageView> {
  final ref = FirebaseDatabase.instance.reference().child('test');
  var isOnOf = false;
  var status = false;
  bool onOf = false;
  bool tipTap = false;
  List<bool> boolList = [false, true, false]; //
  int selectedRoomIndex = -1;
  var currentIndex = 0;
  List<RoomData> roomList = [];
 

  Future<List<RoomData>> fetchDataFromFirebase() async {
    //fetching data from firebase
    final url = Uri.https(
        "sync-verse-4a6e2-default-rtdb.firebaseio.com", "Details.json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      //List<RoomData> roomList = [];

      data?.forEach((key, value) {
        print("this is key");
        print(key);
        final roomNo = value['Room_no'];
        final icon = value['icon'];
        final imageUrl = value['image_url'];
        final onOf = value['isSwitchOn'];
        final deviceName = value['device_Name'];

        RoomData roomData = RoomData(
          roomNo: (roomNo != null) ? roomNo : '',
          icon: icon,
          imageUrl: imageUrl,
          onOf: (onOf != null) ? onOf : false,
          deviceName: deviceName,
          Key: key,
        );

        // Add the room data to the list
        roomList.add(roomData);
      });

      return roomList;
    } else {
      print('Failed to fetch data from Firebase.');
      return []; // return an empty list in case of error
    }
  }

  Future<void> updateRoomSwitchState(String roomId, bool newValue) async {
    try {
      final url = Uri.https("sync-verse-4a6e2-default-rtdb.firebaseio.com",
          "Details/$roomId.json");

      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({'isSwitchOn': newValue}),
      );

      if (response.statusCode != 200) {
        print(
            'Failed to update isSwitchOn in Firebase: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error updating isSwitchOn variable: $error');
    }
  }

  //code to write delete the element

  Future<void> deleteDataFromFirebase(String key) async {
    print("this is the delete key");
    print(key);
    final url = Uri.https(
        "sync-verse-4a6e2-default-rtdb.firebaseio.com", "Details/$key.json");

    final response = await http.delete(url);
    setState(() {
      roomList.removeWhere((element) => element.Key == key);
    });

    if (response.statusCode == 200) {
      print('Data deleted successfully.');
    } else {
      print('Failed to delete data from Firebase.');
    }
  }

  bool isEmergencyNavigating = false;

  void emergency() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => HelpcontactView()));
    });
  }

  void showNotification(String title, String subtitle) {
    print("I'm working");
    // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> HelpCon);

    FlutterLocalNotificationsPlugin().show(
      0,
      title,
      subtitle,
      const NotificationDetails(
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

  Map<int, List<Color>> selectedGradientColors = {};
  List<Color> color1 = const [
    Color.fromARGB(255, 181, 236, 242),
    Color.fromRGBO(1, 202, 210, 1)
  ];
  List<Color> color2 = const [
    Color.fromRGBO(168, 141, 214, 1),
    Color.fromRGBO(110, 62, 190, 1)
  ];
  List<Color> color3 = const [
    Color.fromRGBO(189, 110, 193, 1),
    Color.fromRGBO(190, 62, 169, 1)
  ];
  List<Color> color4 = const [
    Colors.white,
    Color.fromARGB(255, 230, 245, 247),
  ];
  List<Color> color5 = const [
    Colors.red,
    Color.fromARGB(255, 247, 230, 247),
  ];
  var temp;
  var humid;
  var gas;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(231, 238, 250, 1),
          foregroundColor: Colors.black,
          title: Image.asset(
            'assets/SV.png',
            height: 20,
          ),
          leading: IconButton(
              onPressed: () {
                print('drawer');
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu_sharp)),
          bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: Color(0xFF152D5E)),
              indicatorColor: Color.fromRGBO(231, 238, 250, 1),
              automaticIndicatorColorAdjustment: false,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              tabs: const [
                SizedBox(
                  height: 40,
                  width: 100,
                  child: Center(
                      child: Text(
                    "All Devices",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                ),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: Center(
                      child: Text(
                    "Room 1",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                ),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: Center(
                      child: Text(
                    "Room 2",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                ),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: Center(
                      child: Text(
                    "Room 3",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                ),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: Center(
                      child: Text(
                    "Room 4",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                ),
              ]),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  size: 30,
                )),
            IconButton(
                onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ProfileView();
                    })),
                icon: const Icon(
                  Icons.account_circle,
                  size: 30,
                )),
          ],
        ),
        body: StreamBuilder(
            stream: ref.onValue,
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData && snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              }
              dynamic snapshotValue = snapshot.data!.snapshot.value;
              SensorData? sensorData;
              if (snapshotValue is Map<dynamic, dynamic>) {
                Map<dynamic, dynamic> values = snapshotValue;
                sensorData = SensorData.fromSnapshot(values);
                // Now you can safely work with 'values'
                // ...
              } else {
                // Handle the case where 'snapshotValue' is not a Map<dynamic, dynamic>
                // This may occur if the data retrieved doesn't match your expectations
                // ...
              }
              if (sensorData != null) {
                if (sensorData!.gas != null &&
                    double.parse(sensorData.gas) >= 300) {
                  showNotification(
                      '🛑Gas Leaked !!!🛑', '🔥🔥Fire In Hotel🔥🔥');

                  emergency();
                }
              }

              return Stack(
                children: [
                  Container(
                    color: Color.fromRGBO(231, 238, 250, 1),
                  ),
                  TabBarView(children: [
                    //acording to the tab bar we are showing the display changes

                    Center(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            height: MediaQuery.of(context).size.height * 0.27,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                              height: 83,
                                              width: 165,
                                              child: Card(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                                color: const Color.fromRGBO(
                                                    214, 176, 180, 1),
                                                child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 2),
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: (sensorData != null)
                                                        ? Text(
                                                            "${sensorData.Temperature}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )
                                                        : const Text(
                                                            "0",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          )),
                                              )),
                                          const SizedBox(
                                            height: 83,
                                            width: 120,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25))),
                                              color: Color.fromRGBO(
                                                  158, 76, 85, 0.9),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Center(
                                                      child: Text(
                                                    "Temperature",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                  Text(
                                                    "|",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          SizedBox(
                                              height: 83,
                                              width: 165,
                                              child: Card(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),
                                                color: const Color.fromRGBO(
                                                    177, 198, 242, 1),
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: (sensorData != null)
                                                      ? Text(
                                                          sensorData.gas,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      : const Text(
                                                          '0',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 83,
                                            width: 120,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25))),
                                              color: Color.fromRGBO(
                                                  95, 139, 228, 1),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Center(
                                                      child: Text(
                                                    "Gas",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                  Text(
                                                    "|",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: 83,
                                            width: 165,
                                            child: Card(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  25))),
                                              color: const Color.fromRGBO(
                                                  214, 176, 180, 1),
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 2),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: (sensorData != null)
                                                    ? Text(
                                                        sensorData.Humidity,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )
                                                    : const Text(
                                                        '0',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 83,
                                            width: 120,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25))),
                                              color: Color.fromRGBO(
                                                  158, 76, 85, 0.9),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Center(
                                                      child: Text(
                                                    "Humidity",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                  Text(
                                                    "|",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: 83,
                                            width: 165,
                                            child: Card(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  25))),
                                              color: const Color.fromRGBO(
                                                  177, 198, 242, 1),
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: const Text(
                                                  "60",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 83,
                                            width: 120,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25))),
                                              color: Color.fromRGBO(
                                                  95, 139, 228, 1),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Center(
                                                      child: Text(
                                                    "Temperature",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                  Text(
                                                    "|",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          SizedBox(
                            //the below one grid view
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 1,
                            child: FutureBuilder<List<RoomData>>(
                                future: fetchDataFromFirebase(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<RoomData>> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Handle the loading state
                                    return const Center(
                                      child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator()),
                                    );
                                  } else if (snapshot.hasError) {
                                    // Handle the error state
                                    return Column(
                                      children: [
                                        Container(
                                            height: 90,
                                            width: 50,
                                            child:
                                                const CircularProgressIndicator(
                                              color: Colors.greenAccent,
                                            )),
                                        const Center(
                                            child: Text(
                                          "No devices is adaded yet , please choose a subscription",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 158, 216, 243),
                                              fontStyle: FontStyle.italic),
                                        )),
                                      ],
                                    ); //"Error: ${snapshot.error}"
                                  } else {
                                    List<RoomData> roomList = snapshot.data!;
                                    List<bool> boolList = List.generate(
                                        roomList.length, (index) => false);
                                    print("its been taking time");
                                    print(boolList);
                                    return GridView.count(
                                      crossAxisCount: 2,
                                      children:
                                          roomList.asMap().entries.map((entry) {
                                        int index = entry.key;
                                        var catData = entry.value;

                                        return StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter setState) {
                                          return Card(
                                            elevation: 10,
                                            margin: const EdgeInsets.all(10),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25)),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: boolList[index]
                                                        ? (selectedGradientColors[
                                                                index] ??
                                                            (index % 3 == 1
                                                                ? color1
                                                                : index % 3 == 2
                                                                    ? color2
                                                                    : color3))
                                                        : color4, //color4

                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.wifi),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 15),
                                                          height: 30,
                                                          width: 30,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  7),
                                                            ),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  catData
                                                                      .imageUrl),
                                                              height: 10,
                                                              width: 10,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        catData.deviceName,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                          "Room No. ${catData.roomNo}"),
                                                    ),
                                                    const Divider(
                                                      thickness: 1,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.04729,
                                                      child: SizedBox(
                                                        height: 50,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Switch(
                                                                  //switch to on and of
                                                                  onChanged: (bool
                                                                      value) async {
                                                                    setState(
                                                                        () {
                                                                      boolList[
                                                                              index] =
                                                                          value;
                                                                      if (value) {
                                                                        selectedGradientColors[
                                                                            index] = index % 3 ==
                                                                                1
                                                                            ? color1
                                                                            : index % 3 == 2
                                                                                ? color2
                                                                                : color3;
                                                                      } else {
                                                                        selectedGradientColors
                                                                            .remove(index);
                                                                      }
                                                                    });
                                                                    await updateRoomSwitchState(
                                                                        catData
                                                                            .Key,
                                                                        value);
                                                                    print(boolList[
                                                                        index]);
                                                                  },
                                                                  value:
                                                                      boolList[
                                                                          index],
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          15),
                                                                  child: Text(
                                                                    boolList[
                                                                            index]
                                                                        ? "ON"
                                                                        : "OFF",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    try {
                                                                      await deleteDataFromFirebase(
                                                                          catData
                                                                              .Key); // Assuming you have a way to get the room ID
                                                                      // Handle successful deletion
                                                                    } catch (error) {
                                                                      // Handle error
                                                                    }
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .delete),
                                                                ),
                                                              ],
                                                            ),
                                                            //},
                                                            //),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                      }).toList(),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<List<RoomData>>(
                        future: fetchDataFromFirebase(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<RoomData>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Handle the loading state
                            return const Center(
                              child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()),
                            );
                          } else if (snapshot.hasError) {
                            // Handle the error state
                            return Column(
                              children: [
                                Container(
                                    height: 50,
                                    width: 50,
                                    child: const CircularProgressIndicator(
                                      color: Colors.greenAccent,
                                    )),
                                const Center(
                                    child: Text(
                                  "No devices is adaded yet , please choose a subscription",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 158, 216, 243),
                                      fontStyle: FontStyle.italic),
                                )),
                              ],
                            ); //"Error: ${snapshot.error}"
                          } else {
                            List<RoomData> roomList = snapshot.data!;
                            return GridView.count(
                              crossAxisCount: 2,
                              children: roomList
                                  .where((RoomData) => RoomData.roomNo == "1")
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;
                                var e = entry.value;

                                return GestureDetector(
                                  onLongPress: () {
                                    deleteDataFromFirebase(e.Key);
                                  },
                                  child: StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return Card(
                                      elevation: 10,
                                      margin: const EdgeInsets.all(10),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: boolList[index]
                                                  ? (selectedGradientColors[
                                                          index] ??
                                                      (index % 3 == 1
                                                          ? color1
                                                          : index % 3 == 2
                                                              ? color2
                                                              : color3))
                                                  : color4, //color4

                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon:
                                                        const Icon(Icons.wifi),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    height: 30,
                                                    width: 30,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(7),
                                                      ),
                                                      child: Image(
                                                        image: AssetImage(
                                                            e.imageUrl),
                                                        height: 10,
                                                        width: 10,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ListTile(
                                                title: Text(
                                                  e.deviceName,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                    "Room No. ${e.roomNo}"),
                                              ),
                                              const Divider(
                                                thickness: 1,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.056,
                                                child: SizedBox(
                                                  height: 50,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Switch(
                                                            //switch to on and of
                                                            onChanged: (bool
                                                                value) async {
                                                              setState(() {
                                                                boolList[
                                                                        index] =
                                                                    value;
                                                                if (value) {
                                                                  selectedGradientColors[
                                                                      index] = index %
                                                                              3 ==
                                                                          1
                                                                      ? color1
                                                                      : index % 3 ==
                                                                              2
                                                                          ? color2
                                                                          : color3;
                                                                } else {
                                                                  selectedGradientColors
                                                                      .remove(
                                                                          index);
                                                                }
                                                              });
                                                              await updateRoomSwitchState(
                                                                  e.Key, value);
                                                              print(boolList[
                                                                  index]);
                                                            },
                                                            value:
                                                                boolList[index],
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 15),
                                                            child: Text(
                                                              boolList[index]
                                                                  ? "ON"
                                                                  : "OFF",
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                await deleteDataFromFirebase(
                                                                    e.Key); // Assuming you have a way to get the room ID
                                                                // Handle successful deletion
                                                              } catch (error) {
                                                                // Handle error
                                                              }
                                                            },
                                                            icon: const Icon(
                                                                Icons.delete),
                                                          ),
                                                        ],
                                                      ),
                                                      //},
                                                      //),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }).toList(),
                            );
                          }
                        }),
                    FutureBuilder<List<RoomData>>(
                        future: fetchDataFromFirebase(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<RoomData>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Handle the loading state
                            return const Center(
                              child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()),
                            );
                          } else if (snapshot.hasError) {
                            // Handle the error state
                            return const Column(
                              children: [
                                SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(
                                      color: Colors.greenAccent,
                                    )),
                                Center(
                                    child: Text(
                                  "No devices is adaded yet , please choose a subscription",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 158, 216, 243),
                                      fontStyle: FontStyle.italic),
                                )),
                              ],
                            ); //"Error: ${snapshot.error}"
                          } else {
                            List<RoomData> roomList = snapshot.data!;
                            return GridView.count(
                              crossAxisCount: 2,
                              children: roomList
                                  .where((RoomData) => RoomData.roomNo == "2")
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;
                                var e = entry.value;

                                return GestureDetector(onLongPress: () {
                                  deleteDataFromFirebase(e.Key);
                                }, child: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Card(
                                    elevation: 10,
                                    margin: const EdgeInsets.all(10),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: boolList[index]
                                                ? (selectedGradientColors[
                                                        index] ??
                                                    (index % 3 == 1
                                                        ? color1
                                                        : index % 3 == 2
                                                            ? color2
                                                            : color3))
                                                : color4, //color4

                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.wifi),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 15),
                                                  height: 30,
                                                  width: 30,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(7),
                                                    ),
                                                    child: Image(
                                                      image: AssetImage(
                                                          e.imageUrl),
                                                      height: 10,
                                                      width: 10,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ListTile(
                                              title: Text(
                                                e.deviceName,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              subtitle:
                                                  Text("Room No. ${e.roomNo}"),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.056,
                                              child: SizedBox(
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Switch(
                                                          //switch to on and of
                                                          onChanged: (bool
                                                              value) async {
                                                            setState(() {
                                                              boolList[index] =
                                                                  value;
                                                              if (value) {
                                                                selectedGradientColors[
                                                                    index] = index %
                                                                            3 ==
                                                                        1
                                                                    ? color1
                                                                    : index % 3 ==
                                                                            2
                                                                        ? color2
                                                                        : color3;
                                                              } else {
                                                                selectedGradientColors
                                                                    .remove(
                                                                        index);
                                                              }
                                                            });
                                                            await updateRoomSwitchState(
                                                                e.Key, value);
                                                            print(boolList[
                                                                index]);
                                                          },
                                                          value:
                                                              boolList[index],
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 15),
                                                          child: Text(
                                                            boolList[index]
                                                                ? "ON"
                                                                : "OFF",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () async {
                                                            try {
                                                              await deleteDataFromFirebase(
                                                                  e.Key); // Assuming you have a way to get the room ID
                                                              // Handle successful deletion
                                                            } catch (error) {
                                                              // Handle error
                                                            }
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                        ),
                                                      ],
                                                    ),
                                                    //},
                                                    //),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                              }).toList(),
                            );
                          }
                        }),
                    FutureBuilder<List<RoomData>>(
                        future: fetchDataFromFirebase(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<RoomData>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Handle the loading state
                            return const Center(
                              child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()),
                            );
                          } else if (snapshot.hasError) {
                            // Handle the error state
                            return Column(
                              children: [
                                Container(
                                    height: 50,
                                    width: 50,
                                    child: const CircularProgressIndicator(
                                      color: Colors.greenAccent,
                                    )),
                                const Center(
                                    child: Text(
                                  "No devices is adaded yet , please choose a subscription",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 158, 216, 243),
                                      fontStyle: FontStyle.italic),
                                )),
                              ],
                            ); //"Error: ${snapshot.error}"
                          } else {
                            List<RoomData> roomList = snapshot.data!;
                            return GridView.count(
                              crossAxisCount: 2,
                              children: roomList
                                  .where((RoomData) => RoomData.roomNo == "3")
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;
                                var e = entry.value;

                                return GestureDetector(
                                  onLongPress: () {
                                    deleteDataFromFirebase(e.Key);
                                  },
                                  child: StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return Card(
                                      elevation: 10,
                                      margin: const EdgeInsets.all(10),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: boolList[index]
                                                  ? (selectedGradientColors[
                                                          index] ??
                                                      (index % 3 == 1
                                                          ? color1
                                                          : index % 3 == 2
                                                              ? color2
                                                              : color3))
                                                  : color4, //color4

                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon:
                                                        const Icon(Icons.wifi),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    height: 30,
                                                    width: 30,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(7),
                                                      ),
                                                      child: Image(
                                                        image: AssetImage(
                                                            e.imageUrl),
                                                        height: 10,
                                                        width: 10,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ListTile(
                                                title: Text(
                                                  e.deviceName,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                    "Room No. ${e.roomNo}"),
                                              ),
                                              const Divider(
                                                thickness: 1,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.056,
                                                child: SizedBox(
                                                  height: 50,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Switch(
                                                            //switch to on and of
                                                            onChanged: (bool
                                                                value) async {
                                                              setState(() {
                                                                boolList[
                                                                        index] =
                                                                    value;
                                                                if (value) {
                                                                  selectedGradientColors[
                                                                      index] = index %
                                                                              3 ==
                                                                          1
                                                                      ? color1
                                                                      : index % 3 ==
                                                                              2
                                                                          ? color2
                                                                          : color3;
                                                                } else {
                                                                  selectedGradientColors
                                                                      .remove(
                                                                          index);
                                                                }
                                                              });
                                                              await updateRoomSwitchState(
                                                                  e.Key, value);
                                                              print(boolList[
                                                                  index]);
                                                            },
                                                            value:
                                                                boolList[index],
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 15),
                                                            child: Text(
                                                              boolList[index]
                                                                  ? "ON"
                                                                  : "OFF",
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                await deleteDataFromFirebase(
                                                                    e.Key); // Assuming you have a way to get the room ID
                                                                // Handle successful deletion
                                                              } catch (error) {
                                                                // Handle error
                                                              }
                                                            },
                                                            icon: const Icon(
                                                                Icons.delete),
                                                          ),
                                                        ],
                                                      ),
                                                      //},
                                                      //),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }).toList(),
                            );
                          }
                        }),
                    FutureBuilder<List<RoomData>>(
                        future: fetchDataFromFirebase(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<RoomData>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Handle the loading state
                            return const Center(
                              child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()),
                            );
                          } else if (snapshot.hasError) {
                            // Handle the error state
                            return Column(
                              children: [
                                Container(
                                    height: 50,
                                    width: 50,
                                    child: const CircularProgressIndicator(
                                      color: Colors.greenAccent,
                                    )),
                                const Center(
                                    child: Text(
                                  "No devices is adaded yet , please choose a subscription",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 158, 216, 243),
                                      fontStyle: FontStyle.italic),
                                )),
                              ],
                            ); //"Error: ${snapshot.error}"
                          } else {
                            List<RoomData> roomList = snapshot.data!;
                            return GridView.count(
                              crossAxisCount: 2,
                              children: roomList
                                  .where((RoomData) => RoomData.roomNo == "4")
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;
                                var e = entry.value;

                                return GestureDetector(
                                  onLongPress: () {
                                    deleteDataFromFirebase(e.Key);
                                  },
                                  child: StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return Card(
                                      elevation: 10,
                                      margin: const EdgeInsets.all(10),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: boolList[index]
                                                  ? (selectedGradientColors[
                                                          index] ??
                                                      (index % 3 == 1
                                                          ? color1
                                                          : index % 3 == 2
                                                              ? color2
                                                              : color3))
                                                  : color4, //color4

                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon:
                                                        const Icon(Icons.wifi),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    height: 30,
                                                    width: 30,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(7),
                                                      ),
                                                      child: Image(
                                                        image: AssetImage(
                                                            e.imageUrl),
                                                        height: 10,
                                                        width: 10,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ListTile(
                                                title: Text(
                                                  e.deviceName,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                    "Room No. ${e.roomNo}"),
                                              ),
                                              const Divider(
                                                thickness: 1,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.056,
                                                child: SizedBox(
                                                  height: 50,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Switch(
                                                            //switch to on and of
                                                            onChanged: (bool
                                                                value) async {
                                                              setState(() {
                                                                boolList[
                                                                        index] =
                                                                    value;
                                                                if (value) {
                                                                  selectedGradientColors[
                                                                      index] = index %
                                                                              3 ==
                                                                          1
                                                                      ? color1
                                                                      : index % 3 ==
                                                                              2
                                                                          ? color2
                                                                          : color3;
                                                                } else {
                                                                  selectedGradientColors
                                                                      .remove(
                                                                          index);
                                                                }
                                                              });
                                                              await updateRoomSwitchState(
                                                                  e.Key, value);
                                                              print(boolList[
                                                                  index]);
                                                            },
                                                            value:
                                                                boolList[index],
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 15),
                                                            child: Text(
                                                              boolList[index]
                                                                  ? "ON"
                                                                  : "OFF",
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                await deleteDataFromFirebase(
                                                                    e.Key); // Assuming you have a way to get the room ID
                                                                // Handle successful deletion
                                                              } catch (error) {
                                                                // Handle error
                                                              }
                                                            },
                                                            icon: const Icon(
                                                                Icons.delete),
                                                          ),
                                                        ],
                                                      ),
                                                      //},
                                                      //),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }).toList(),
                            );
                          }
                        }),
                  ]),
                ],
              );
            }),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String
      label; //here by making a string variable we are updating the label of tabbar dynamically

  final indexx;

  const RepeatedTab({
    super.key,
    required this.label,
    required this.indexx,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: SizedBox(
          width: 100,
          child: Center(
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ),
      ),
    );
  }
}

class publicDetails {
  String roomNo, equipment, imageLink;
  final IconData icon;
  var temp;
  var sname = "";

  var isOnOf = false;

  publicDetails({
    required this.roomNo,
    required this.equipment,
    required this.icon,
    required this.imageLink,
    required this.isOnOf,
    required this.temp,
    required this.sname,
  });
}

class RoomData {
  final String roomNo;
  final String icon;
  final String imageUrl;
  late final bool onOf;
  final String deviceName;
  var Key;

  RoomData({
    required this.roomNo,
    required this.icon,
    required this.imageUrl,
    required this.onOf,
    required this.deviceName,
    required this.Key,
  });
}*/
