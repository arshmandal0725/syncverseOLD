import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:syncverse/app/modules/adddevices/views/adddevices_view.dart';
import 'package:syncverse/app/modules/biometricpage/views/biometricpage_view.dart';
import 'package:syncverse/app/modules/firstPage/views/first_page_view.dart';
import 'package:syncverse/app/modules/home_screen/views/drawer.dart';
import 'package:syncverse/app/modules/home_screen/views/home_screen_view.dart';
import 'package:syncverse/app/modules/profile/views/profile_view.dart';
import 'package:syncverse/app/modules/shop/views/shop_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    FirstPageView(),
    /*HomeScreenView()*/ AddDevices(),
    ProfileView(),
    BiometricpageView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Image.asset('assets/sync.png'),
        // title: const Text(
        //   'Sync Verse',
        //   style: TextStyle(color: Colors.black),
        // ),
        bottom: ,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active_outlined,
                size: 30,
              )),
          IconButton(
              onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ProfileView();
                  })),
              icon: Icon(
                Icons.account_circle,
                size: 30,
              )),

          // IconButton(
          //     onPressed: () {
          //       auth
          //           .signOut()
          //           .then((value) => Get.off(() => LoginScreenView()));
          //     },
          //     icon: Icon(Icons.logout)
          //     ),
        ],
      ),*/
      extendBody: true,
      drawer: MyDrawer(),
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SalomonBottomBar(
              unselectedItemColor: Colors.white,
              backgroundColor: Color(0xfff1D3557),
              // backgroundColor: Colors.white,
              // margin: EdgeInsets.only(left: 10, right: 10),
              duration: Duration(milliseconds: 3500),

              items: [
                SalomonBottomBarItem(
                    icon: Image.asset(
                      'assets/Icons/home.png',
                      height: 22,
                    ),
                    title: Text(''),
                    selectedColor: Colors.white
                    // selectedColor: Color(0xfff1D3557),
                    ),
                SalomonBottomBarItem(
                    icon: Image.asset(
                      'assets/Icons/devices.png',
                      height: 22,
                    ),
                    title: Text(''),
                    selectedColor: Colors.white
                    // selectedColor: Color(0xfff1D3557),
                    ),
                SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    title: Text(''),
                    selectedColor: Colors.white
                    // selectedColor: Color(0xfff1D3557),
                    ),
                // SalomonBottomBarItem(
                //     icon: Icon(Icons.fingerprint),
                //     title: Text(''),
                //     selectedColor: Colors.white
                //     // selectedColor: Color(0xfff1D3557),
                //     ),
              ],
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
            ),
          ),
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

/*class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Harsh'),
      ),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            "Home Page",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}*/

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Image.asset('assets/sync.png'),
        // title: const Text(
        //   'Sync Verse',
        //   style: TextStyle(color: Colors.black),
        // ),

        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active_outlined,
                size: 30,
              )),
          IconButton(
              onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ProfileView();
                  })),
              icon: Icon(
                Icons.account_circle,
                size: 30,
              )),

          // IconButton(
          //     onPressed: () {
          //       auth
          //           .signOut()
          //           .then((value) => Get.off(() => LoginScreenView()));
          //     },
          //     icon: Icon(Icons.logout)
          //     ),
        ],
      ),
      body: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            "Profile",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

/*class MyItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Center(
        child: Text(
          "Items Page",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}*/
