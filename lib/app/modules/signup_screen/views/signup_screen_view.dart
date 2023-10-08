import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:syncverse/app/modules/login_screen/views/login_screen_view.dart';
import 'package:syncverse/app/modules/login_screen/views/muinfo.dart';
import 'package:syncverse/app/modules/login_screen/views/otp.dart';
import 'package:syncverse/utils.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../controllers/signup_screen_controller.dart';

// ignore: must_be_immutable
class SignupScreenView extends GetView<SignupScreenController> {
  SignupScreenView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  var _emailAdress = '';
  final passwordController = TextEditingController();
  var _passWord = '';
  final confirmPasswordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var countrycode = '+91';
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  var verify = '';

  void next() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await _auth.verifyPhoneNumber(
        phoneNumber: countrycode + phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          verify = verificationId;
          Get.off(getOtp(
              verificationId: verify,
              emailaddress: _emailAdress,
              password: _passWord,
              phonenum: phoneNumberController.text));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = const Text(
      "Next",
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
    );
    if (loading) {
      widget = const Center(
        child: CircularProgressIndicator(),
      );
    }
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
            ),
            Center(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: constraints.maxHeight * 0.68,
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
                    child: GlassContainer(
                      blur: double.infinity,
                      opacity: 0.2,
                      borderRadius: BorderRadius.circular(25),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 26, top: 10),
                              child: const Text(
                                "Create Account",
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 20,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          constraints: BoxConstraints(
                                              maxHeight: 60, maxWidth: 310),
                                          isDense: true,
                                          border: InputBorder.none,
                                          label: Text(
                                            "Email Address",
                                            style: TextStyle(),
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value != null &&
                                              value.trim().isNotEmpty &&
                                              value.contains('@')) {
                                            return null;
                                          }
                                          return 'Enter vallid email adress';
                                        },
                                        onSaved: (value) {
                                          _emailAdress = value!;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 2, right: 2),
                                    child: IntlPhoneField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        constraints:
                                            const BoxConstraints(maxWidth: 310),
                                        labelText: 'Phone Number',
                                        labelStyle: const TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17,
                                        ),
                                      ),
                                      initialCountryCode: 'IN',
                                      controller: phoneNumberController,
                                      onCountryChanged: (value) {
                                        countrycode = value.fullCountryCode;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: mediquery.size.height * 0.02,
                                  ),
                                  Card(
                                    //color: const Color.fromRGBO(255, 125, 200, 0.5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 20,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value != null &&
                                              value.trim().isNotEmpty &&
                                              value.trim().length >= 6) {
                                            return null;
                                          }
                                          return 'Enter vallid password';
                                        },
                                        onSaved: (value) {
                                          _passWord = value!;
                                        },
                                        controller: passwordController,
                                        decoration: const InputDecoration(
                                          constraints: BoxConstraints(
                                              maxHeight: 60, maxWidth: 310),
                                          border: InputBorder.none,
                                          label: Text("Password"),
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
                                  SizedBox(
                                    height: mediquery.size.height * 0.02,
                                  ),
                                  Card(
                                    //color: const Color.fromRGBO(255, 125, 200, 0.5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 20,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: TextFormField(
                                        controller: confirmPasswordController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Confirm Password is required";
                                          }
                                          if (value !=
                                              passwordController.text) {
                                            return "Passwords do not match";
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          constraints: BoxConstraints(
                                              maxHeight: 60, maxWidth: 310),
                                          border: InputBorder.none,
                                          label: Text("Confirm Password"),
                                          labelStyle: TextStyle(
                                            // letterSpacing: 1,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: mediquery.size.height * 0.02,
                                  ),
                                  SizedBox(
                                    width: 335,
                                    height: 60,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 20,
                                      color:
                                          const Color.fromRGBO(97, 197, 201, 1),
                                      child: TextButton(
                                          onPressed: () {
                                            next();
                                          },
                                          child: widget),
                                    ),
                                  ),
                                  SizedBox(
                                    height: mediquery.size.height * 0.004,
                                  ),
                                  Center(
                                    child: Container(
                                      width: constraints.maxWidth * 1,
                                      margin: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Allready have an account?",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Get.off(LoginScreenView());
                                              },
                                              child: const Text(
                                                "Login Here",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      97, 197, 201, 1),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          //),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //),
    );
  }
}
