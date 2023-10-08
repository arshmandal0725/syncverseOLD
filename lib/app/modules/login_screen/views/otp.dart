import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:pinput/pinput.dart';
import 'package:syncverse/app/modules/login_screen/views/muinfo.dart';
//import 'package:syncverse/app/modules/home_screen/views/bottom_navigation.dart';
//import 'package:syncverse/app/modules/login_screen/views/muinfo.dart';

class getOtp extends StatefulWidget {
  final String verificationId;
  final String emailaddress;
  final String  password;
  final  String phonenum;
  getOtp(
      {super.key,
      required this.verificationId,
      required this.emailaddress,
      required this.password,
      required this.phonenum});

  @override
  State<getOtp> createState() => _getOtpState();
}

class _getOtpState extends State<getOtp> {
  var userName = "";
  final auth = FirebaseAuth.instance;
  var otpcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
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
                height: constraints.maxHeight * 0.6,
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
                    opacity: 0.145,
                    borderRadius: BorderRadius.circular(25),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: const Text(
                                "Verify with OTP",
                                style: TextStyle(
                                    color: Color.fromRGBO(222, 230, 235, 1),
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(1.4, 1.4),
                                        blurRadius: 10,
                                        //color: Color.fromRGBO(104, 108, 162, 1),
                                      ),
                                    ],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mediquery.size.height * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20),
                                child: const Center(
                                  child: Text(
                                    "We,ve sent a 6-digit confirmation code to your Mobile No.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromRGBO(239, 243, 245, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mediquery.size.height * 0.04,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Pinput(
                                  length: 6,
                                  pinputAutovalidateMode:
                                      PinputAutovalidateMode.onSubmit,
                                  showCursor: true,
                                  controller: otpcontroller,
                                ),
                              ),
                              SizedBox(
                                height: mediquery.size.height * 0.04,
                              ),
                              SizedBox(
                                width: 335,
                                height: 60,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 20,
                                  color: const Color.fromRGBO(97, 197, 201, 1),
                                  child: TextButton(
                                    onPressed: () async {
                                      try {
                                        PhoneAuthCredential credential =
                                            PhoneAuthProvider.credential(
                                                verificationId:
                                                    widget.verificationId,
                                                smsCode: otpcontroller.text);

                                        await auth
                                            .signInWithCredential(credential);
                                        Get.off(MyInform(
                                            emailaddress: widget.emailaddress,
                                            password: widget.password,
                                            phonenum: widget.phonenum));
                                      } catch (e) {}
                                    },
                                    child: const Text(
                                      "Verify",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mediquery.size.height * 0.03,
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Didn't recieve code?"),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            "Resend Code?",
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
            )
          ],
        ),
      ),
      //),
    );
  }
}
