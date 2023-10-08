import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../database_api.dart';
import 'package:http/http.dart' as http;

import 'profile_view.dart';

class AddressChange extends StatefulWidget {
  const AddressChange({super.key});

  @override
  State<AddressChange> createState() => _AddressChangeState();
}

class _AddressChangeState extends State<AddressChange> {
  TextEditingController _changeAddress = TextEditingController();
  API c = Get.put(API());
  void updateDetails() async {
    var url = "https://svdatabase.onrender.com/sv/profilrupdate";
    // var data = {
    //   "name": _name.text.toString(),
    //   "phone": int.parse(_phone.text),
    //   "email": _email.text.toString(),
    //   "location": _location.text.toString(),
    //   "place": _placeOfUse.text.toString(),
    //   "photo": "no Photo"
    // };
    var data = {
      "name": c.filteredData[0].name,
      "phone": c.filteredData[0].phone,
      "email": c.filteredData[0].email,
      "location": _changeAddress.text.toString(),
      "place": c.filteredData[0].place,
      "photo": c.filteredData[0].photo
    };
    print(data);
    var body = json.encode(data);
    var urlParse = Uri.parse(url);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    try {
      http.Response response =
          await http.put(urlParse, headers: headers, body: body);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      // ...
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
        centerTitle: true,
        backgroundColor: Color(0xFF152D5E),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Change your Address.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                )),
            SizedBox(
              height: 12,
            ),
            Form(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Address',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _changeAddress,
                    decoration: InputDecoration(
                        hintText: 'Address Line 1',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Address Line 2',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Address Line 3',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Begin Your New Address',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 300,
          child: FloatingActionButton.extended(
              backgroundColor: Color(0xFF152D5E),
              onPressed: () {
                final snackBar = SnackBar(
                                    content: const Text('Data Updated Succesfully'),
                                  );

                                  // Find the ScaffoldMessenger in the widget tree
                                  // and use it to show a SnackBar.
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                updateDetails();
                Get.to(ProfileView());
              },
              label: Center(child: Text('Continue'))),
        ),
      ),
    );
  }
}
