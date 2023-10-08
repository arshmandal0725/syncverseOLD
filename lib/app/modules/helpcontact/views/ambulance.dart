// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class AmbulanceButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         _launchAmbulanceCall();
//       },
//       child: Text('Call Ambulance'),
//     );
//   }

//  _launchAmbulanceCall() async {
//   var url = Uri.parse("tel:9268450965");
//   print("Trying to launch: $url");

//   if (await canLaunch(url.toString())) {
//     print("Launching...");
//     await launch(url.toString());
//     print("Launched successfully");
//   } else {
//     print("Could not launch");
//     throw 'Could not launch $url';
//   }
// }

// }
