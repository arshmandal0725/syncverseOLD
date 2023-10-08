import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncverse/app/modules/home_screen/views/bottom_navigation.dart';
import 'package:syncverse/app/modules/home_screen/views/device.dart';
import 'package:syncverse/app/modules/home_screen/views/drawer.dart';
import 'package:syncverse/app/modules/login_screen/views/login_screen_view.dart';
import '../controllers/home_screen_controller.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  final ref = FirebaseDatabase.instance.reference().child('test');
  final auth = FirebaseAuth.instance;
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChange(int i) {
    _selectedTab = _SelectedTab.values[i];
  }

  HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   foregroundColor: Colors.black,
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   title: Image.asset('assets/sync.png'),
      //   // title: const Text(
      //   //   'Sync Verse',
      //   //   style: TextStyle(color: Colors.black),
      //   // ),
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.notifications_active_outlined)),
      //     IconButton(
      //         onPressed: () {}, icon: Icon(Icons.account_circle_outlined)),

      //     // IconButton(
      //     //     onPressed: () {
      //     //       auth
      //     //           .signOut()
      //     //           .then((value) => Get.off(() => LoginScreenView()));
      //     //     },
      //     //     icon: Icon(Icons.logout)),
      //   ],
      // ),
      // drawer: MyDrawer(),
      body: Row(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => Device());
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.46,
              height: MediaQuery.of(context).size.height * 0.16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xfff1D3557),
              ),
              margin: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'LPG and Fire Detector',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
          // TextButton(
          //     onPressed: () {
          //       Get.to(() => MyHomePage());
          //     },
          //     child: Text('hello'))
        ],
      ),
      // bottomNavigationBar:
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: DotNavigationBar(
      //     ,margin: EdgeInsets.only(left: 10, right: 10)
      //     currentIndex: _SelectedTab.values.indexOf(_selectedTab),
      // dotIndicatorColor: Colors.black,
      // unselectedItemColor: Colors.green,
      // backgroundColor: Colors.amber,
      //     onTap: _handleIndexChange,
      //     items: [
      //       DotNavigationBarItem(
      //           icon: Icon(Icons.home), selectedColor: Colors.orange),
      //       DotNavigationBarItem(
      //           icon: Icon(Icons.search), selectedColor: Colors.orange),
      //       DotNavigationBarItem(
      //           icon: Icon(Icons.access_alarms_outlined),
      //           selectedColor: Colors.orange),
      //       DotNavigationBarItem(
      //           icon: Icon(Icons.kitchen_outlined),
      //           selectedColor: Colors.orange),
      //     ],
      //   ),
      // ),
    );

    // );
  }
}

enum _SelectedTab { home, favourite, search, kitch }
