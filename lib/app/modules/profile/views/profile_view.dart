import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncverse/app/modules/profile/views/ChangeName.dart';
import 'package:syncverse/app/modules/profile/views/changeAddress.dart';
import 'package:syncverse/app/modules/profile/views/changeEmail.dart';
import 'package:syncverse/app/modules/profile/views/changeNumber.dart';
import 'package:syncverse/app/modules/profile/views/changePlace.dart';
import 'package:syncverse/app/modules/profile/views/funct.dart';
import 'package:syncverse/app/modules/profile/views/profilecont.dart';
import 'package:syncverse/back_services.dart';
import 'package:syncverse/database_api.dart';

import '../../../../model.dart';
import '../controllers/profile_controller.dart';
import 'package:http/http.dart' as http;

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  // API c = Get.put(API());

  @override
  Widget build(BuildContext context) {
    final String apiUrl =
        'https://svdatabase.onrender.com/sv'; // Replace with your API URL
    final String targetEmail =
        'harsh@gmail.com'; // Replace with the target email

    List<UserData> filteredData = [];
    API c = Get.put(API());
// API c = Get.find<API>();
    @override
    void initState() {
      // super.initState();
      Get.put(API());
      c.fetchData();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
          backgroundColor: Color(0xFF152D5E),
          elevation: 0,
        ),
        body: Obx(() {
          if (c.filteredData.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFF152D5E), Color(0x00152D5E)],
                      ),
                    ),
                    child: Center(
                        child: CircleAvatar(
                      radius: 80,
                      child: Icon(
                        Icons.account_circle,
                        size: 160,
                      ),
                    )),
                  ),
                  Card(
                    elevation: 15,
                    child: Container(
                      width: 327,
                      height: 370,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return NameChange();
                              })),
                              leading: Image.asset(
                                'assets/personalIcons/profile.png',
                                height: 23,
                              ),
                              title: Text('Name'),
                              subtitle: Text(c.filteredData[0].name),
                              trailing: Icon(CupertinoIcons.pen),
                            ),
                            ListTile(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return PhoneNumberChange();
                              })),
                              leading: Image.asset(
                                'assets/personalIcons/mail.png',
                                height: 23,
                              ),
                              title: Text('Phone'),
                              subtitle:
                                  Text(c.filteredData[0].phone.toString()),
                              trailing: Icon(CupertinoIcons.pen),
                            ),
                            ListTile(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return EmailChange();
                              })),
                              leading: Image.asset(
                                'assets/personalIcons/mail.png',
                                height: 23,
                              ),
                              title: Text('E-mail Address'),
                              subtitle: Text(c.filteredData[0].email),
                              trailing: Icon(CupertinoIcons.pen),
                            ),
                            ListTile(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return AddressChange();
                              })),
                              leading: Image.asset(
                                'assets/personalIcons/location.png',
                                height: 23,
                              ),
                              title: Text('Location'),
                              subtitle: Text(c.filteredData[0].location),
                              trailing: Icon(CupertinoIcons.pen),
                            ),
                            ListTile(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return PlaceChange();
                              })),
                              leading: Image.asset(
                                'assets/personalIcons/hotel.png',
                                height: 23,
                              ),
                              title: Text('Place of use'),
                              subtitle: Text(c.filteredData[0].place),
                              trailing: Icon(CupertinoIcons.pen),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  // Obx(() => setState(){});
                                  final snackBar = SnackBar(
                                    content: const Text('Data Fetched Succesfully'),
                                  );

                                  // Find the ScaffoldMessenger in the widget tree
                                  // and use it to show a SnackBar.
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  initState();
                                  c.fetchData();

                                  setState() {}
                                },
                                child: Text("Refresh"))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        }));
  }
}
