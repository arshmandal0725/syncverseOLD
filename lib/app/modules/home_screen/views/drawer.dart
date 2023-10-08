import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:syncverse/app/modules/faq/views/faq_view.dart';
import 'package:syncverse/app/modules/help/views/help_view.dart';
import 'package:syncverse/app/modules/login_screen/views/login_screen_view.dart';

import '../../setting/views/setting_view.dart';
//import 'package:syncverse/app/modules/settings/seting.dart';
//import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            // decoration: BoxDecoration(borderRadius: BorderRadius.only()),
            width: 316,
            height: 250,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                color: Color(0xfff1D3557),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xfff1D3557),
                child: Icon(
                  Icons.account_circle_sharp,
                  size: 80,
                ),
              ),
              accountName: Text('SyncVerse'),
              accountEmail: Text('syncverse@gmail.com'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 260, // Replace 200 with your desired width
              height: 60, // Replace 80 with your desired height
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: const Offset(
                        4.0,
                        4.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                  color: Color(0xFFE0E1DC),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: ListTile(
                        leading: Image.asset('assets/Icons/about.png'),
                        title: Text(
                          'About',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Container(
          //     width: 260, // Replace 200 with your desired width
          //     height: 60, // Replace 80 with your desired height
          //     decoration: BoxDecoration(
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black45,
          //             offset: const Offset(
          //               5.0,
          //               5.0,
          //             ),
          //             blurRadius: 10.0,
          //             spreadRadius: 2.0,
          //           ),
          //         ],
          //         color: Color(0xFFE0E1DC),
          //         borderRadius: BorderRadius.only(
          //             topRight: Radius.circular(40),
          //             bottomRight: Radius.circular(40))),
          // child: Column(
          //   children: [
          //     Expanded(
          //       child: Center(
          //         child: ListTile(
          //           leading: Icon(
          //             Icons.wifi,
          //             size: 30,
          //           ),
          //           title: Text(
          //             'Wi-Fi Connectivity',
          //             style: TextStyle(fontSize: 18),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 260, // Replace 200 with your desired width
              height: 60, // Replace 80 with your desired height
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: const Offset(
                        4.0,
                        4.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                  color: Color(0xFFE0E1DC),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: ListTile(
                        onTap: GotoSettings,
                        leading: Image.asset(
                          'assets/Icons/settings.png',
                          scale: 0.8,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 260, // Replace 200 with your desired width
              height: 60, // Replace 80 with your desired height
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: const Offset(
                        4.0,
                        4.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                  color: Color(0xFFE0E1DC),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: ListTile(
                        onTap: () {
                          Get.to(FaqView());
                        },
                        leading: Image.asset('assets/Icons/faq.png'),
                        title: Text(
                          'FAQ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 260, // Replace 200 with your desired width
              height: 60, // Replace 80 with your desired height
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: const Offset(
                        4.0,
                        4.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                  color: Color(0xFFE0E1DC),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: ListTile(
                        onTap: () {
                          Get.to(HelpView());
                        },
                        leading: Image.asset('assets/Icons/help.png'),
                        title: Text(
                          'Help',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 3,
          ),
          // ListTile(
          //   leading: Icon(Icons.call),
          //   title: Text('Contact Us'),
          // ),
          // SizedBox(
          //   height: 2,
          // ),
          // ListTile(
          //   leading: Icon(Icons.handshake_outlined),
          //   title: Text('Help'),
          // ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {
              auth.signOut().then((value) => Navigator.of(context)
                      .pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                    return LoginScreenView();
                  })));
            },
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }

  void GotoSettings() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return SettingView();
    }));
  }
}
