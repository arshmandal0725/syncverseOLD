

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
// import 'package:syncverse/app/modules/helpcontact/views/ambulance.dart';
// import 'package:syncverse/app/modules/profile/views/ChangeName.dart';
// import 'package:syncverse/app/modules/profile/views/changeAddress.dart';
// import 'package:syncverse/app/modules/profile/views/profile_view.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:action_slider/action_slider.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'dart:math' as math;
import '../controllers/helpcontact_controller.dart';

class HelpcontactView extends GetView<HelpcontactController> {
  const HelpcontactView({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  // 'assets/firegif.gif',
                  'assets/fire.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Center(
            // Positioned(
            //   left: 20,
            //   child: Transform.rotate(
            //     angle: -math.pi / 2,
            //     child: ActionSlider.standard(
            //       width: 200,
            //       // child: Text('Slide to Call Ambulance'),
            //       toggleColor: Colors.red,
            //       action: (controller) async {
            //         FlutterPhoneDirectCaller.callNumber('102');
            //       },
            //     ),
            //   ),
            // ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                     FlutterPhoneDirectCaller.callNumber('102');
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Call \nAmbulance',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
                InkWell(
                  onTap: (){
                     FlutterPhoneDirectCaller.callNumber('100');
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Call \nPolice',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
