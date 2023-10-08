import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncverse/app/modules/profile/views/profile_view.dart';

import '../../../../database_api.dart';
import 'package:http/http.dart' as http;

class PlaceChange extends StatefulWidget {
  @override
  _PlaceChangeState createState() => _PlaceChangeState();
}

class _PlaceChangeState extends State<PlaceChange> {
  TextEditingController _placeOfUse = TextEditingController();
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
      "location": c.filteredData[0].location,
      "place": _placeOfUse.text.toString(),
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

  int selectedCardIndex = -1;
  List<String> placeNames = [
    'Home',
    'Industry',
    'Restaurant',
    'Hotel',
    'Others'
  ];
  List<String> placeImg = [
    'assets/Homephoto.png',
    'assets/indusphoto.png',
    'assets/restphoto.png',
    'assets/hotelphoto.png',
    'assets/otherphoto.png'
  ];

  @override
  Widget build(BuildContext context) {
    if (c.filteredData[0].place == 'Home') {
      selectedCardIndex = 0;
    }
    if (c.filteredData[0].place == 'Industry') {
      selectedCardIndex = 1;
    }
    if (c.filteredData[0].place == 'Restaurant') {
      selectedCardIndex = 2;
    }
    if (c.filteredData[0].place == 'Hotel') {
      selectedCardIndex = 3;
    }
    if (c.filteredData[0].place == 'Others') {
      selectedCardIndex = 4;
    }
    Widget places(String title, int index, String imgTitle) {
      bool isSelected = selectedCardIndex == index;

      return Card(
        color: isSelected ? Colors.green : null,
        elevation: isSelected ? 4 : 1,
        child: Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  // Update the selected card index
                  selectedCardIndex = isSelected ? -1 : index;
                });
              },
              child: Center(
                  child: ListTile(
                onTap: () {
                  setState(() {
                    selectedCardIndex = isSelected ? -1 : index;
                  });

                  if (isSelected) {
                    _placeOfUse.text = title;
                  }
                },
                leading: Image.asset(imgTitle),
                title: Text(title),
              ))),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        centerTitle: true,
        backgroundColor: Color(0xFF152D5E),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Choose your Place of Use',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: placeNames.length,
                  itemBuilder: (context, index) {
                    return places(placeNames[index], index, placeImg[index]);
                  },
                ),
              ),
            ),
            TextFormField(
              controller: _placeOfUse,
              decoration: InputDecoration(hintText: 'If others,specify'),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 300,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xFF152D5E),
          onPressed: () {
            final snackBar = SnackBar(
              content: const Text('Data Updated Succesfully'),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            updateDetails();
            Get.to(ProfileView());
          },
          label: Center(child: Text('Update Name')),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: PlaceChange(),
//   ));
// }
