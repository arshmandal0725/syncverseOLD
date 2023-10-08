import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:syncverse/app/modules/helpcontact/views/helpcontact_view.dart';
import './app/modules/firstPage/views/first_page_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: true, autoStart: true));
}

// late double a = 0.0;
// String b = "";
// void getDataBackend(String gas) {
//   // a = gas;
//   b = gas;
// }

// Function to fetch data from Firebase
Future<Map<String, dynamic>> fetchDataFromFirebase() async {
  final url = Uri.parse(
      'https://syncverse-firebase-default-rtdb.firebaseio.com/test.json');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return Map<String, dynamic>.from(data);
  } else {
    throw Exception('Failed to fetch data from Firebase.');
  }
}

var a;
var b;
// Function to update data variables
void updateDataVariables(Map<String, dynamic> data) {
  a = data['gas'] ?? 0;
  b = data['Temperature'] ?? 0;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
// my new code

  DartPluginRegistrant.ensureInitialized();
  
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: "Notifi", content: "Notifi content");
      }
    }
    // function to write
    // Fetch data and update variables
    try {
      Map<String, dynamic> fetchedData = await fetchDataFromFirebase();
      updateDataVariables(fetchedData);
      if (a != null && a >= 300) {
        showNotification('🛑Gas Leaked !!!🛑', '🔥🔥Fire In Hotel🔥🔥');
        print('Background service running');
        print('Value of a: $a');
        print('Value of b: $b');
        // Get.to(FirstPageView());
       
        // Print other values from fetchedData if needed
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  });
}

void showNotification(String title, String subtitle) {
  print("I'm working");
  // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> HelpCon);

  FlutterLocalNotificationsPlugin().show(
    0,
    title,
    subtitle,
    payload:'navigate_to_emergency',
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


// OverlayEntry _buildOverlayEntry() {
//   return OverlayEntry(
//     builder: (context) {
//       return Center(
//         child: Container(
//           width: 200,
//           height: 200,
//           color: Colors.red,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Overlay Screen'),
//               ElevatedButton(
//                 onPressed: () {
//                   overlayEntry?.remove();
//                   overlayEntry = null;
//                 },
//                 child: Text('Close Overlay'),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

class NotificationHandler{
  static Future<void> navigate_to_emergency(BuildContext context) async {
    // Perform navigation to the homepage
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HelpcontactView()),
    );
  }
}