import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';

class SignInSetting extends StatefulWidget {
  const SignInSetting({super.key});

  @override
  State<SignInSetting> createState() => _SignInSettingState();
}

class _SignInSettingState extends State<SignInSetting> {
  final _formKey = GlobalKey<FormState>();
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  var tap = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF152D5E),
        title: Text("Sign-In Settings"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Account Settings",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Password",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 55,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: currentPassword,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    label: Text("Enter Password"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "New Password",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 55,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: newPassword,
                                  decoration: InputDecoration(
                                      label: Text("Enter Password"),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, bottom: 30),
                        child: Text(
                          "See Password requirements below",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(left: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Password Requirements:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Text(
                      ".   Must include at least 8 character",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      ".   Must include at least on uppercase number",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      ".   Must include at least on lowercase number",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      ".   Must include at least on number",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              ListTile(
                leading: Icon(
                  Icons.fingerprint,
                  size: 30,
                  color: Colors.black,
                ),
                title: Text(
                  "Sign in With Biometrics",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: Switch(
                  onChanged: (Value) {
                    setState(() {
                      if (tap == false) {
                        tap = true;
                      } else {
                        tap = false;
                      }
                    });
                  },
                  value: tap,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.21,
              ),
              Center(
                child: Container(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF152D5E),
                    ),
                    onPressed: () {},
                    child: Text("Upload"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
