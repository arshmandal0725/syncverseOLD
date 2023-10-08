import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncverse/app/modules/setting/views/deviceupdate.dart';
import 'package:syncverse/app/modules/setting/views/sign.dart';
import 'package:syncverse/app/modules/setting/views/subscription.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxInt selectedRadio = 0.obs;

    return LayoutBuilder(
      builder: (context, Constraints) => Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          elevation: 0,
          backgroundColor: Color(0xFF152D5E),
        ),
        body: Column(
          children: [
            Container(
              height: Constraints.maxHeight * 0.2,
              width: Constraints.maxWidth * 1,
              //height: MediaQuery.of(context).size.height * 0.2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF152D5E), Color(0x00152D5E)],
                ),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                /*boxShadow: [
                    BoxShadow(
                        color: Colors.white70,
                        blurRadius: 10,
                        offset: Offset(0, 1))
                  ]*/
              ),
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.account_circle,
                        size: 150,
                      ),
                      radius: 80,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 60, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AmanKumar Upadhyay",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "7488****73",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                ListTile(
                  onTap: () {
                    GotoSubscription(context);
                  },
                  leading: Icon(Icons.subscriptions),
                  title: Text('Subscription'),
                  subtitle: Text('See your plans'),
                  trailing: Icon(Icons.logout),
                ),
                ListTile(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const SignInSetting();
                  })),
                  leading: Icon(Icons.key),
                  title: Text('Sign-in setting'),
                  subtitle: Text('Change your password, Biometric login'),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Temperature Unit'),
                          content: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile(
                                    title: Text('Celsius'),
                                    value: 1,
                                    groupValue: selectedRadio.value,
                                    onChanged: (val) {
                                      selectedRadio.value = val!;
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text('Fahrenheit'),
                                    value: 2,
                                    groupValue: selectedRadio.value,
                                    onChanged: (val) {
                                      selectedRadio.value = val!;
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  leading: Icon(Icons.ac_unit),
                  title: Text('Temperature unit'),
                  subtitle: Text('Change temperature unit'),
                ),
                ListTile(
                  /*onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ;
                      })),*/
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DeviceUpdate();
                    }));
                  },
                  leading: Icon(Icons.devices_other),
                  title: Text('Device Update'),
                ),
                ListTile(
                  /*onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ;
                      })),*/
                  leading: Icon(Icons.privacy_tip),
                  title: Text('Privacy settings'),
                ),
                ListTile(
                  /*onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ;
                      })),*/
                  leading: Icon(Icons.checklist),
                  title: Text('Privacy policy management'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void GotoSubscription(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return MySubscription();
    }));
  }
}
