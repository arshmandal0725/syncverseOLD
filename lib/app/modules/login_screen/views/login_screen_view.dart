import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncverse/app/modules/home_screen/views/bottom_navigation.dart';
import 'package:syncverse/app/modules/signup_screen/views/signup_screen_view.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

import '../../../../utils.dart';
import '../controllers/login_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreenView extends GetView<LoginScreenController> {
  LoginScreenView({Key? key}) : super(key: key);

  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void dispose() {
    Get.delete();
  }

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      // throw Exception('An error occurred');
      Get.off(() => MyHomePage());
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final mediquery = MediaQuery.of(context);

    return LayoutBuilder(
        builder: (context, constraints) => Scaffold(
              //appBar: AppBar(),
              body: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/Picsart_23-07-09_09-18-48-431.jpg"),
                        fit: BoxFit.cover),
                  ),
                  height: constraints.maxHeight * 1,
                  //height: MediaQuery.of(context).size.height * 1,
                  //color: const Color.fromARGB(255, 187, 240, 250),
                ),
                Center(
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.65,
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
                          height: constraints.maxHeight,
                          child: SingleChildScrollView(
                            //physics: const NeverScrollableScrollPhysics(),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 26, top: 10),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Color.fromRGBO(154, 158, 162, 1),
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(1.4, 1.4),
                                            blurRadius: 15,
                                          ),
                                        ],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: mediquery.size.height * 0.02,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: constraints.maxHeight * 0.08,
                                      width: constraints.maxWidth * 0.85,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        elevation: 20,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          child: TextFormField(
                                            controller: emailController,
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
                                            onSaved: (value) {
                                              //userName = value!;
                                            },
                                          ),
                                        ),
                                        //),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediquery.size.height * 0.02,
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.08,
                                      width: constraints.maxWidth * 0.85,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        elevation: 20,
                                        child: /* Form(
                                        child:*/
                                            Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          child: TextFormField(
                                            controller: passwordController,
                                            obscureText: _isObscure,
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                icon: Icon(_isObscure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off),
                                                onPressed: () {
                                                  _isObscure = !_isObscure;
                                                },
                                              ),
                                              border: InputBorder.none,
                                              labelText: "Password",
                                              labelStyle: const TextStyle(
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
                                    SizedBox(
                                      width: 335,
                                      height: 60,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        elevation: 20,
                                        color: const Color.fromRGBO(
                                            97, 197, 201, 1),
                                        child: TextButton(
                                          onPressed: login,
                                          child: const Text(
                                            "LOGIN",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediquery.size.height * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          child: TextButton(
                                              onPressed: () {
                                                Get.to(() => MyHomePage());
                                              },
                                              child: const Text(
                                                "Forget Password ?",
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      97, 197, 201, 1),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mediquery.size.height * 0.02,
                                    ),
                                    Container(
                                      width: constraints.maxWidth,
                                      margin: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: const Center(
                                        child: Text(
                                          "------------------------or continue with------------------------",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromRGBO(
                                                154, 158, 162, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediquery.size.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            color: Colors.white,
                                            Icons.apple,
                                            size: 50,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            color: Colors.white,
                                            Icons.facebook,
                                            size: 50,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            color: Colors.white,
                                            Icons.g_mobiledata_outlined,
                                            size: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mediquery.size.height * 0.01,
                                    ),
                                    Center(
                                      child: Container(
                                        width: constraints.maxWidth * 1,
                                        margin: const EdgeInsets.all(14),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Don't have an account?",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromRGBO(
                                                    154, 158, 162, 1),
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Get.off(SignupScreenView());
                                                },
                                                child: const Text(
                                                  "Register Now",
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        97, 197, 201, 1),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
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
                  ),
                )
              ]),
            ));
  }
}
