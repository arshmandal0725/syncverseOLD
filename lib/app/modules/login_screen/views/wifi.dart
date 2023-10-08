import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class Wifii extends StatefulWidget {
  const Wifii({super.key});

  @override
  State<Wifii> createState() => _WifiiState();
}

class _WifiiState extends State<Wifii> {
  var userName = "";
  @override
  Widget build(BuildContext context) {
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
                height: constraints.maxHeight * 0.55,
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
                    opacity: 0.1,
                    borderRadius: BorderRadius.circular(25),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 26, top: 10),
                            child: const Text(
                              "Wi-Fi",
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
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Center(
                            child: Card(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              elevation: 20,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    height: 45,
                                    child: Card(
                                      color:
                                          const Color.fromRGBO(128, 228, 232, 1)
                                              .withOpacity(0.6),
                                      //color: const Color.fromRGBO(255, 125, 200, 0.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 7,
                                      child: Form(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxHeight: 60, maxWidth: 310),
                                              border: InputBorder.none,
                                              label: Text("Wifi Name"),
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
                                  ),
                                  /* SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.02,
                                    ),*/
                                  Container(
                                    margin: EdgeInsets.only(left: 5, right: 5),
                                    height: 45,
                                    child: Card(
                                      color: Color.fromRGBO(128, 228, 232, 1)
                                          .withOpacity(0.6),
                                      //color: const Color.fromRGBO(255, 125, 200, 0.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 7,
                                      child: Form(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxHeight: 60, maxWidth: 310),
                                              border: InputBorder.none,
                                              label: Text("Wifi Name"),
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
                                  ),
                                  /* SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.02,
                                    ),*/
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 5, right: 5, top: 5),
                                    height: 45,
                                    child: Card(
                                      color: Color.fromRGBO(128, 228, 232, 1)
                                          .withOpacity(0.6),
                                      //color: const Color.fromRGBO(255, 125, 200, 0.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 7,
                                      child: Form(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxHeight: 60, maxWidth: 310),
                                              border: InputBorder.none,
                                              label: Text("Wifi Name"),
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
                                  ),
                                  /* SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.02,
                                    ),*/
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 5, right: 5, top: 5),
                                    height: 45,
                                    child: Card(
                                      color: Color.fromRGBO(128, 228, 232, 1)
                                          .withOpacity(0.6),
                                      //color: const Color.fromRGBO(255, 125, 200, 0.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 7,
                                      child: Form(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxHeight: 60, maxWidth: 310),
                                              border: InputBorder.none,
                                              label: Text("Wifi Name"),
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
                                  ),
                                  /* SizedBox(
                                      height: MediaQuery.of(context).size.height *
                                          0.02,
                                    ),*/
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 5, right: 5, top: 5, bottom: 5),
                                    height: 45,
                                    child: Card(
                                      color: Color.fromRGBO(128, 228, 232, 1)
                                          .withOpacity(0.6),
                                      //color: const Color.fromRGBO(255, 125, 200, 0.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 7,
                                      child: Form(
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              constraints: BoxConstraints(
                                                  maxHeight: 60, maxWidth: 310),
                                              border: InputBorder.none,
                                              label: Text("Wifi Name"),
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Center(
                            child: SizedBox(
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
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Next",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                        //),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
