import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syncverse/app/modules/adddevices/views/device_setup.dart';

class TakingData extends StatefulWidget {
  var tappedName = "";
  var imageUrl = "";
  TakingData({super.key, required this.tappedName, required this.imageUrl});

  @override
  State<TakingData> createState() => _TakingDataState();
}

class _TakingDataState extends State<TakingData> {
  final _formKey = GlobalKey<FormState>();
  var _roomNo = "";
  var Imageurl = "";
  var isOnOf;

  var icon = "";

  /*final List<Map<String, dynamic>> exhaust = [
    {
      "image": 
      "icon": 
      "IsOnOf": bool,
    }
  ];*/
  //snackbar message
  SnackBar snackBar = const SnackBar(
    backgroundColor: Colors.white54,
    elevation: 10,
    padding: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    content: Text(
      "Device is added",
      style: TextStyle(color: Colors.black),
    ),
  );

  void SentDataFirebase(String icon, imagelink, bool onOf) async {
    // final url = Uri.https("synccversee-default-rtdb.firebaseio.com",
    //     "Details.json"); ////syncverse-c8be1-default-rtdb.firebaseio.com
    final url = Uri.https("sync-verse-4a6e2-default-rtdb.firebaseio.com",
        "Details.json"); ////syncverse-c8be1-default-rtdb.firebaseio.com

    final response = await http.post(
      url,
      headers: {
        //sending request to save the data in the backend
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "Room_no": _roomNo,
          "icon": icon,
          "image_url": imagelink,
          "isSwitchOn": onOf,
          "device_Name": widget.tappedName,
        },
      ),
    );
    print(response.body);
  }

  //devices condition by switch case
  void CasesSwitch() {
    switch (widget.tappedName) {
      case "Exhaust":
        {
          _formKey.currentState!.save();
          icon = "Icon(Icons.wifi)";
          Imageurl = "assets/images/run.gif";
          isOnOf = true;
          SentDataFirebase(icon, Imageurl, isOnOf);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        break;
      case "Smart Regulator":
        {
          _formKey.currentState!.save();
          icon = "Icons.wifi";
          Imageurl = "assets/images/wave.jpg";
          isOnOf = false;
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          SentDataFirebase(icon, Imageurl, isOnOf);
        }

        break;
      case "Main Hub":
        {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            icon = "Icon(Icons.wifi)";
            Imageurl = "assets/images/bulb.gif";
            isOnOf = false;
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            SentDataFirebase(icon, Imageurl, isOnOf);
          }
        }
        break;
      case "Smart Light":
        {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            icon = "Icon(Icons.wifi)";
            Imageurl = "assets/images/bulb.gif";
            isOnOf = false;
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            SentDataFirebase(icon, Imageurl, isOnOf);
          }
        }
        break;
      case "MCB":
        {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            icon = "Icon(Icons.wifi)";
            Imageurl = "assets/images/mcbgif.gif";
            isOnOf = false;
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            SentDataFirebase(icon, Imageurl, isOnOf);
          }
        }
        break;
      case "Child Hub":
        {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            icon = "Icon(Icons.wifi)";
            Imageurl = "assets/images/wave.jpg";
            isOnOf = false;
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            SentDataFirebase(icon, Imageurl, isOnOf);
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tappedName),
        backgroundColor: const Color(0xFF152D5E),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: const Color.fromRGBO(231, 238, 250, 1),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: 400,
                  height: 300,
                  child: Card(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      child: Image(
                        image: AssetImage(widget.imageUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  child: Card(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty ||
                            value.length >= 8) {
                          return "Enter a valid Room no.";
                        }
                        return null;
                      },
                      initialValue: _roomNo,
                      onSaved: (newValue) {
                        _roomNo = newValue!;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none, label: Text("Room No.")),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF152D5E),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                      // onPressed: CasesSwitch,
                      onPressed: () {
                        CasesSwitch();
                        Get.to(DeviceSetup());
                      },
                      child: Text("Submit")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
