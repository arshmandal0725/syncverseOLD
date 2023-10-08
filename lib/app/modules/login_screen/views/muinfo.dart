import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:syncverse/app/modules/home_screen/views/bottom_navigation.dart';
import 'package:syncverse/app/modules/home_screen/views/home_screen_view.dart';
import 'package:syncverse/app/modules/login_screen/views/login_screen_view.dart';
import 'package:syncverse/app/modules/login_screen/views/wifi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class MyInform extends StatefulWidget {
  final String emailaddress;
  final String password;
  final String phonenum;
  const MyInform(
      {super.key,
      required this.emailaddress,
      required this.password,
      required this.phonenum});

  @override
  State<MyInform> createState() => _MyInformState();
}

class _MyInformState extends State<MyInform> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  var userName = "";
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final  TextEditingController _email = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _placeOfUse = TextEditingController();
  void saveDetails() async {
    var url = "https://svdatabase.onrender.com/sv/userinfodata";
    var data = {
      "name": _name.text.toString(),
      "phone": int.parse(_phone.text),
      "email": _email.text.toString(),
      "location": _location.text.toString(),
      "place": _placeOfUse.text.toString(),
      "photo": "no Photo"
    };
    var body = json.encode(data);
    var urlParse = Uri.parse(url);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      http.Response response =
          await http.post(urlParse, headers: headers, body: body);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
     // Get.off(LoginScreenView());
      // ...
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    delete();
    super.initState();
  }

  void signup() {
    _auth.createUserWithEmailAndPassword(
      email: widget.emailaddress,
      password: widget.password,
    );
    Get.off(MyHomePage());
    saveDetails();
  }

  void delete() async {
    final User? user = FirebaseAuth.instance.currentUser;
    await user!.delete();
  }

  @override
  Widget build(BuildContext context) {
    final mediquery = MediaQuery.of(context);
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/Picsart_23-07-09_09-18-48-431.jpg"),
                    fit: BoxFit.cover),
              ),
              //color: const Color.fromARGB(255, 187, 240, 250),
            ),
            Center(
              child: SizedBox(
                height: constraints.maxHeight * 0.63,
                width: constraints.maxWidth,
                child: Card(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 20,
                  color: Colors.transparent.withOpacity(0),

                  //color: const Color.fromRGBO(52, 69, 86, 0.9),
                  //color: const Color.fromRGBO(255, 187, 240, 0.7),
                  child: GlassContainer(
                    blur: double.infinity,
                    opacity: 0.2,
                    borderRadius: BorderRadius.circular(25),
                    child: SingleChildScrollView(
                      //physics: const NeverScrollableScrollPhysics(),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 26, top: 10),
                            child: const Text(
                              "Personal Information",
                              style: TextStyle(
                                color: Color.fromRGBO(154, 158, 162, 1),
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.4, 1.4),
                                    blurRadius: 15,
                                    //color: Color.fromRGBO(154, 158, 162, 1),
                                  ),
                                ],
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mediquery.size.height * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 20,
                                child: Form(
                                  key: _formKey,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      controller: _name,
                                      decoration: const InputDecoration(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, maxWidth: 310),
                                        isDense: true,
                                        border: InputBorder.none,
                                        label: Text(
                                          "Name",
                                          style: TextStyle(),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      onSaved: (value) {
                                        userName = value!;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mediquery.size.height * 0.02,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 20,
                                child: Form(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      controller: _phone,
                                      decoration: const InputDecoration(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, maxWidth: 310),
                                        isDense: true,
                                        border: InputBorder.none,
                                        label: Text(
                                          "Phone",
                                          style: TextStyle(),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      onSaved: (value) {
                                        userName = value!;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mediquery.size.height * 0.02,
                              ),
                              Card(
                                //color: const Color.fromRGBO(255, 125, 135, 0.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 20,
                                child: Form(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      controller: _email,
                                      decoration: const InputDecoration(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, maxWidth: 310),
                                        border: InputBorder.none,
                                        label: Text("Email"),
                                        labelStyle: TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mediquery.size.height * 0.02,
                              ),
                              Card(
                                //color: const Color.fromRGBO(255, 125, 135, 0.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 20,
                                child: Form(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      controller: _location,
                                      decoration: const InputDecoration(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, maxWidth: 310),
                                        border: InputBorder.none,
                                        label: Text("Location"),
                                        labelStyle: TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mediquery.size.height * 0.01,
                              ),
                              Card(
                                //color: const Color.fromRGBO(255, 125, 135, 0.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 20,
                                child: Form(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      controller: _placeOfUse,
                                      decoration: const InputDecoration(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, maxWidth: 310),
                                        border: InputBorder.none,
                                        label: Text("Place of use"),
                                        labelStyle: TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mediquery.size.height * 0.08,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 135,
                                    height: 50,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      elevation: 20,
                                      color: Color.fromRGBO(97, 197, 201, 1),
                                      child: TextButton(
                                        onPressed: () {
                                          // Navigator.of(context).pop();
                                          print(_name);
                                          print(_phone);
                                          print(_email);
                                          print(_location);
                                          print(_placeOfUse);
                                          signup();
                                        },
                                        child: const Text(
                                          "Submit",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mediquery.size.height * 0.01,
                              ),
                            ],
                          ),
                        ],
                        //),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
