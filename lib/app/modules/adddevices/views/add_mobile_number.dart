import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncverse/database_api.dart';
import 'package:http/http.dart' as http;

class AddMobileNumber extends StatefulWidget {
  const AddMobileNumber({super.key});

  @override
  State<AddMobileNumber> createState() => _AddMobileNumberState();
}

class _AddMobileNumberState extends State<AddMobileNumber> {
  TextEditingController _mobileNumber = TextEditingController();
  API c = Get.put(API());
  List<bool> _giveVerseList = [];
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
    List existingCallList = c.filteredData[0].calllist;

    // Add the new mobile number to the existing calllist
    existingCallList.add(_mobileNumber.text.toString());
    var data = {
      "name": c.filteredData[0].name,
      "phone": c.filteredData[0].phone,
      "email": c.filteredData[0].email,
      "location": c.filteredData[0].location,
      "place": c.filteredData[0].place,
      "calllist": existingCallList.toList(),
      "photo": c.filteredData[0].photo,
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
      _mobileNumber.clear();
      setState(() {
      _giveVerseList.add(false);
    });
      // ...
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize _giveVerseList with default switch states
    _giveVerseList =
        List.generate(c.filteredData[0].calllist.length, (index) => false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text('Add Mobile Number'),
      ),
      body: Column(
        children: [
          Form(
              child: SizedBox(
            height: 100,
            child: Card(
              elevation: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      "Add More Number",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: Card(
                          margin: EdgeInsets.all(5),
                          child: TextFormField(
                            controller: _mobileNumber,
                            decoration: InputDecoration(hintText: "Enter No."),
                          ),
                        ),
                      ),
                      Container(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF152D5E),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                              onPressed: () {
                                updateDetails();
                              },
                              child: Text("Save"))),
                    ],
                  ),
                ],
              ),
            ),
          )),
          Expanded(
              child: ListView.builder(
                  itemCount: c.filteredData[0].calllist.length,
                  itemBuilder: (context, index) {
                    final mobile = c.filteredData[0].calllist[index];
                    return ListTile(
                        title: Text('$mobile'),
                        trailing: Switch(
                          value: _giveVerseList[index],
                          onChanged: (bool newValue) {
                            setState(() {
                             _giveVerseList[index] = newValue;
                            });
                          },
                        ));
                  }))
        ],
      ),
    );
  }
}
