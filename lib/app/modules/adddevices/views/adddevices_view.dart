
import 'package:flutter/material.dart';
import 'package:syncverse/app/modules/adddevices/views/add_mobile_number.dart';
import 'package:syncverse/app/modules/adddevices/views/reference.dart';
import 'package:syncverse/app/modules/adddevices/views/takingData.dart';
import 'package:syncverse/app/modules/firstPage/views/first_page_view.dart';

// import 'package:syncverse/app/modules/adddevices/deviceDetail.dart';
// import 'package:syncverse/app/modules/adddevices_setting/views/takingdata.dart';
import 'package:syncverse/app/modules/home_screen/views/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import '../../firstPage/views/first_page_view.dart';
import '../../profile/views/profile_view.dart';
import 'package:get/get.dart';
import 'package:syncverse/database_api.dart';

class AddDevices extends StatefulWidget {
  const AddDevices({super.key});

  @override
  State<AddDevices> createState() => _AddDevicesState();
}

class _AddDevicesState extends State<AddDevices> {
  Map<int, List<Color>> selectedGradientColors = {};
  List<Color> color1 = const [
    Color.fromARGB(255, 181, 236, 242),
    Color.fromRGBO(1, 202, 210, 1)
  ];
  List<Color> color2 = const [
    Color.fromRGBO(168, 141, 214, 1),
    Color.fromRGBO(110, 62, 190, 1)
  ];
  List<Color> color3 = const [
    Color.fromRGBO(189, 110, 193, 1),
    Color.fromRGBO(190, 62, 169, 1)
  ];
  List<Color> color4 = const [
    Colors.white,
    Color.fromARGB(255, 230, 245, 247),
  ];
  List<RoomData> roomList = [];
  Future<void> updateRoomSwitchState(String roomId, bool newValue) async {
    try {
      final url = Uri.https("sync-verse-4a6e2-default-rtdb.firebaseio.com",
          "Details/$roomId.json");

      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({'isSwitchOn': newValue}),
      );

      if (response.statusCode != 200) {
        print(
            'Failed to update isSwitchOn in Firebase: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error updating isSwitchOn variable: $error');
    }
  }

  Future<void> deleteDataFromFirebase(String key) async {
    print("this is the delete key");
    print(key);
    final url = Uri.https(
        "syncverseapp-default-rtdb.firebaseio.com", "Details/$key.json");

    final response = await http.delete(url);
    setState(() {
      roomList.removeWhere((element) => element.Key == key);
    });

    if (response.statusCode == 200) {
      print('Data deleted successfully.');
    } else {
      print('Failed to delete data from Firebase.');
    }
  }

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
      "name": c.filteredData[0].toString(),
      "phone": c.filteredData[0].phone,
      "email": c.filteredData[0].email,
      "location": c.filteredData[0].location,
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

  TextEditingController _addMobileNumber = TextEditingController();
  @override
  void initState() {
    super.initState();
    _addMobileNumber.text =
        "Initial Value"; // You can set an initial value if needed
  }

  var currentIndex = 0;

  var imageUrl = "assets/images/run.gif";
  Future<List<RoomData>> fetchDataFromFirebase() async {
    final url =
        Uri.https("syncverseapp-default-rtdb.firebaseio.com", "Details.json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<RoomData> roomList = [];

      data?.forEach((key, value) {
        final roomNo = value['Room_no'];
        final icon = value['icon'];
        final imageUrl = value['image_url'];
        final onOf = value['onOf'];
        final deviceName = value['device_Name'];

        RoomData roomData = RoomData(
          roomNo: (roomNo != null) ? roomNo : '',
          icon: icon,
          imageUrl: (imageUrl != null) ? imageUrl : '',
          onOf: (onOf != null) ? onOf : false,
          deviceName: deviceName,
          Key: key,
        );

        // Add the room data to the list
        roomList.add(roomData);
      });

      return roomList;
    } else {
      print('Failed to fetch data from Firebase.');
      return []; // return an empty list in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget ContainerBox(
      title,
      tappedName,
      imageUrl,
    ) {
      var value = title;
      return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return TakingData(
            tappedName: tappedName,
            imageUrl: imageUrl,
          );
        })),
        child: Container(
          width: 173,
          height: 75,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Color(0xfff1f6fe)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Center(
                      child: Text(
                    value,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ))),
            ],
          ),
        ),
      );
    }

    Future Devices() {
      return showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          showDragHandle: true,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContainerBox("Smart Regulator", "Smart Regulator",
                          "assets/images/wave.jpg"),
                      ContainerBox(
                          "Main Hub", "Main Hub", "assets/images/bulb.gif"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContainerBox("Smart Light", "Smart Light",
                          "assets/images/bulb.gif"),
                      ContainerBox("MCB", "MCB", "assets/images/mcbgif.gif"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContainerBox(
                          "Child Hub", "Child Hub", "assets/images/mcbgif.gif"),
                      ContainerBox(
                          "Exhaust", "Exhaust", "assets/images/run.gif"),
                    ],
                  ),
                ],
              ),
            );
          });
    }

    Widget hasNoData() {
      return Container(
        height: MediaQuery.of(context).size.height * 1,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1,
              margin: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Good Morning , XYZ",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        fontStyle: FontStyle.normal),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.003,
                  ),
                  const Text(
                    "Devices 0",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontStyle: FontStyle.normal),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 15,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      color: Colors.white,
                      child: Image.asset("assets/images/device1.jfif.jpg"),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.35, //35
              alignment: Alignment.bottomCenter,
              child: Container(
                //margin: const EdgeInsets.only(bottom: 15),
                width: 300,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      maximumSize: const Size(500, 150),
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF152D5E)),
                  onPressed: () {
                    Devices();
                    /*Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return DeviceDetails();//
                        },
                      ),
                    );*/
                  },
                  child: const Text("Add Device"),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget Room(int index) {
      return MyRoom(
        roomNoo: "$index",
      );
    }


    Widget AllDevices() {
      return Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<RoomData>>(
                  future: fetchDataFromFirebase(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<RoomData>> snapshot) {
                    if (!snapshot.hasData) {
                      return hasNoData();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Handle the loading state
                      return const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()),
                      );
                    } else if (snapshot.hasError) {
                      // Handle the error state
                      return Column(
                        children: [
                          Container(
                              height: 50,
                              width: 50,
                              child: const CircularProgressIndicator(
                                color: Colors.greenAccent,
                              )),
                          const Center(
                              child: Text(
                            "No devices is adaded yet , please choose a subscription",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Color.fromARGB(255, 158, 216, 243),
                                fontStyle: FontStyle.italic),
                          )),
                        ],
                      ); //"Error: ${snapshot.error}"
                    } else {
                      List<RoomData> roomList = snapshot.data!;
                      List<bool> boolList =
                          List.generate(roomList.length, (index) => false);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: const Text(
                              "Smart Room",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: const Text(
                              "Devices  (1)",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 85,
                            width: 400,
                            child: Card(
                              margin: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: ListTile(
                                onTap: () {
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(snackBar);
                                  Get.to(AddMobileNumber());
                                },
                                title: Text("Notification to phone No."),
                                subtitle: Text("7488****73"),
                                trailing: Icon(Icons.notification_add),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              children: roomList.asMap().entries.map((entry) {
                                int index = entry.key;
                                var catData = entry.value;

                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Card(
                                    elevation: 10,
                                    margin: const EdgeInsets.all(10),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: boolList[index]
                                                ? (selectedGradientColors[
                                                        index] ??
                                                    (index % 3 == 1
                                                        ? color1
                                                        : index % 3 == 2
                                                            ? color2
                                                            : color3))
                                                : color4, //color4

                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.wifi),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 15),
                                                  height: 30,
                                                  width: 30,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(7),
                                                    ),
                                                    child: Image(
                                                      image: AssetImage(
                                                          catData.imageUrl),
                                                      height: 10,
                                                      width: 10,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ListTile(
                                              title: Text(
                                                catData.deviceName,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              subtitle: Text(
                                                  "Room No. ${catData.roomNo}"),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.056,
                                              child: SizedBox(
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Switch(
                                                          //switch to on and of
                                                          onChanged: (bool
                                                              value) async {
                                                            setState(() {
                                                              boolList[index] =
                                                                  value;
                                                              if (value) {
                                                                selectedGradientColors[
                                                                    index] = index %
                                                                            3 ==
                                                                        1
                                                                    ? color1
                                                                    : index % 3 ==
                                                                            2
                                                                        ? color2
                                                                        : color3;
                                                              } else {
                                                                selectedGradientColors
                                                                    .remove(
                                                                        index);
                                                              }
                                                            });
                                                            await updateRoomSwitchState(
                                                                catData.Key,
                                                                value);
                                                            print(boolList[
                                                                index]);
                                                          },
                                                          value:
                                                              boolList[index],
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 15),
                                                          child: Text(
                                                            boolList[index]
                                                                ? "ON"
                                                                : "OFF",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () async {
                                                            try {
                                                              await deleteDataFromFirebase(
                                                                  catData
                                                                      .Key); // Assuming you have a way to get the room ID
                                                              // Handle successful deletion
                                                            } catch (error) {
                                                              // Handle error
                                                            }
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                        ),
                                                      ],
                                                    ),
                                                    //},
                                                    //),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ),
          ],
        ),
      );
    }

   

    return DefaultTabController(
      length: roomData.length + 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(231, 238, 250, 1),
          foregroundColor: Colors.black,
          title: Image.asset('assets/sync.png'),
          bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: const Color(0xFF152D5E)),
              indicatorColor: const Color.fromRGBO(231, 238, 250, 1),
              automaticIndicatorColorAdjustment: false,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              tabs: List.generate(roomData.length + 1, (index) {
                if (index == 0) {
                  return InkWell(
                    onLongPress: () {
                      setState(() {
                        roomData.add([]);
                      });
                    },
                    child: const SizedBox(
                        width: 100,
                        height: 30,
                        child: Icon(
                          Icons.add,
                        )),
                  );
                } else {
                  return SizedBox(
                    height: 40,
                    width: 100,
                    child: Center(
                        child: Text(
                      "Room $index",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    )),
                  );
                }
              })),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  size: 30,
                )),
            IconButton(
                onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ProfileView();
                    })),
                icon: const Icon(
                  Icons.account_circle,
                  size: 30,
                )),
          ],
        ),
        drawer: MyDrawer(),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              color: const Color.fromRGBO(231, 238, 250, 1),
            ),
            TabBarView(
                children: List.generate(roomData.length + 1, (index) {
              if (index == 0) {
                return AllDevices();
              } else {
                return Room(index);
              }
            })),
          ],
        ),
      ),
    );
  }
}

class RoomData {
  var roomNo = "";
  var icon;
  var imageUrl = "";
  var onOf;
  var deviceName;
  var Key;
  RoomData(
      {required this.roomNo,
      required this.icon,
      required this.onOf,
      required this.imageUrl,
      required this.deviceName,
      required this.Key});
}































//import 'package:flutter/gestures.dart';
/*import 'package:flutter/material.dart';
import 'package:syncverse/app/modules/adddevices/views/add_mobile_number.dart';
import 'package:syncverse/app/modules/adddevices/views/reference.dart';
import 'package:syncverse/app/modules/adddevices/views/takingData.dart';
import 'package:syncverse/app/modules/firstPage/views/first_page_view.dart';

// import 'package:syncverse/app/modules/adddevices/deviceDetail.dart';
// import 'package:syncverse/app/modules/adddevices_setting/views/takingdata.dart';
import 'package:syncverse/app/modules/home_screen/views/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import '../../firstPage/views/first_page_view.dart';
import '../../profile/views/profile_view.dart';
import 'package:get/get.dart';
import 'package:syncverse/database_api.dart';

class AddDevices extends StatefulWidget {
  const AddDevices({super.key});

  @override
  State<AddDevices> createState() => _AddDevicesState();
}

class _AddDevicesState extends State<AddDevices> {
  Map<int, List<Color>> selectedGradientColors = {};
  List<Color> color1 = const [
    Color.fromARGB(255, 181, 236, 242),
    Color.fromRGBO(1, 202, 210, 1)
  ];
  List<Color> color2 = const [
    Color.fromRGBO(168, 141, 214, 1),
    Color.fromRGBO(110, 62, 190, 1)
  ];
  List<Color> color3 = const [
    Color.fromRGBO(189, 110, 193, 1),
    Color.fromRGBO(190, 62, 169, 1)
  ];
  List<Color> color4 = const [
    Colors.white,
    Color.fromARGB(255, 230, 245, 247),
  ];
  List<RoomData> roomList = [];
  Future<void> updateRoomSwitchState(String roomId, bool newValue) async {
    try {
      final url = Uri.https("sync-verse-4a6e2-default-rtdb.firebaseio.com",
          "Details/$roomId.json");

      final response = await http.patch(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({'isSwitchOn': newValue}),
      );

      if (response.statusCode != 200) {
        print(
            'Failed to update isSwitchOn in Firebase: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error updating isSwitchOn variable: $error');
    }
  }

  Future<void> deleteDataFromFirebase(String key) async {
    print("this is the delete key");
    print(key);
    final url = Uri.https(
        "syncverseapp-default-rtdb.firebaseio.com", "Details/$key.json");

    final response = await http.delete(url);
    setState(() {
      roomList.removeWhere((element) => element.Key == key);
    });

    if (response.statusCode == 200) {
      print('Data deleted successfully.');
    } else {
      print('Failed to delete data from Firebase.');
    }
  }

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
      "name": c.filteredData[0].toString(),
      "phone": c.filteredData[0].phone,
      "email": c.filteredData[0].email,
      "location": c.filteredData[0].location,
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

  TextEditingController _addMobileNumber = TextEditingController();
  @override
  void initState() {
    super.initState();
    _addMobileNumber.text =
        "Initial Value"; // You can set an initial value if needed
  }

  var currentIndex = 0;

  var imageUrl = "assets/images/run.gif";
  Future<List<RoomData>> fetchDataFromFirebase() async {
    final url =
        Uri.https("syncverseapp-default-rtdb.firebaseio.com", "Details.json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<RoomData> roomList = [];

      data?.forEach((key, value) {
        final roomNo = value['Room_no'];
        final icon = value['icon'];
        final imageUrl = value['image_url'];
        final onOf = value['onOf'];
        final deviceName = value['device_Name'];

        RoomData roomData = RoomData(
          roomNo: (roomNo != null) ? roomNo : '',
          icon: icon,
          imageUrl: (imageUrl != null) ? imageUrl : '',
          onOf: (onOf != null) ? onOf : false,
          deviceName: deviceName,
          Key: key,
        );

        // Add the room data to the list
        roomList.add(roomData);
      });

      return roomList;
    } else {
      print('Failed to fetch data from Firebase.');
      return []; // return an empty list in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget ContainerBox(
      title,
      tappedName,
      imageUrl,
    ) {
      var value = title;
      return GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return TakingData(
            tappedName: tappedName,
            imageUrl: imageUrl,
          );
        })),
        child: Container(
          width: 173,
          height: 75,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Color(0xfff1f6fe)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Center(
                      child: Text(
                    value,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ))),
            ],
          ),
        ),
      );
    }

    Future Devices() {
      return showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          showDragHandle: true,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContainerBox("Smart Regulator", "Smart Regulator",
                          "assets/images/wave.jpg"),
                      ContainerBox(
                          "Main Hub", "Main Hub", "assets/images/bulb.gif"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContainerBox("Smart Light", "Smart Light",
                          "assets/images/bulb.gif"),
                      ContainerBox("MCB", "MCB", "assets/images/mcbgif.gif"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContainerBox(
                          "Child Hub", "Child Hub", "assets/images/mcbgif.gif"),
                      ContainerBox(
                          "Exhaust", "Exhaust", "assets/images/run.gif"),
                    ],
                  ),
                ],
              ),
            );
          });
    }

    Widget hasNoData() {
      return Container(
        height: MediaQuery.of(context).size.height * 1,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1,
              margin: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Good Morning , XYZ",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                        fontStyle: FontStyle.normal),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.003,
                  ),
                  const Text(
                    "Devices 0",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontStyle: FontStyle.normal),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 15,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      color: Colors.white,
                      child: Image.asset("assets/images/device1.jfif.jpg"),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.35, //35
              alignment: Alignment.bottomCenter,
              child: Container(
                //margin: const EdgeInsets.only(bottom: 15),
                width: 300,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      maximumSize: const Size(500, 150),
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF152D5E)),
                  onPressed: () {
                    Devices();
                    /*Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return DeviceDetails();//
                        },
                      ),
                    );*/
                  },
                  child: const Text("Add Device"),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget Room(int index) {
      return MyRoom(
        roomNoo: "$index",
      );
    }


    Widget AllDevices() {
      return Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<RoomData>>(
                  future: fetchDataFromFirebase(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<RoomData>> snapshot) {
                    if (!snapshot.hasData) {
                      return hasNoData();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Handle the loading state
                      return const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()),
                      );
                    } else if (snapshot.hasError) {
                      // Handle the error state
                      return Column(
                        children: [
                          Container(
                              height: 50,
                              width: 50,
                              child: const CircularProgressIndicator(
                                color: Colors.greenAccent,
                              )),
                          const Center(
                              child: Text(
                            "No devices is adaded yet , please choose a subscription",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Color.fromARGB(255, 158, 216, 243),
                                fontStyle: FontStyle.italic),
                          )),
                        ],
                      ); //"Error: ${snapshot.error}"
                    } else {
                      List<RoomData> roomList = snapshot.data!;
                      List<bool> boolList =
                          List.generate(roomList.length, (index) => false);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: const Text(
                              "Smart Room",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: const Text(
                              "Devices  (1)",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 85,
                            width: 400,
                            child: Card(
                              margin: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: ListTile(
                                onTap: () {
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(snackBar);
                                  Get.to(AddMobileNumber());
                                },
                                title: Text("Notification to phone No."),
                                subtitle: Text("7488****73"),
                                trailing: Icon(Icons.notification_add),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              children: roomList.asMap().entries.map((entry) {
                                int index = entry.key;
                                var catData = entry.value;

                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Card(
                                    elevation: 10,
                                    margin: const EdgeInsets.all(10),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: boolList[index]
                                                ? (selectedGradientColors[
                                                        index] ??
                                                    (index % 3 == 1
                                                        ? color1
                                                        : index % 3 == 2
                                                            ? color2
                                                            : color3))
                                                : color4, //color4

                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.wifi),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 15),
                                                  height: 30,
                                                  width: 30,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(7),
                                                    ),
                                                    child: Image(
                                                      image: AssetImage(
                                                          catData.imageUrl),
                                                      height: 10,
                                                      width: 10,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ListTile(
                                              title: Text(
                                                catData.deviceName,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              subtitle: Text(
                                                  "Room No. ${catData.roomNo}"),
                                            ),
                                            const Divider(
                                              thickness: 1,
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.056,
                                              child: SizedBox(
                                                height: 50,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Switch(
                                                          //switch to on and of
                                                          onChanged: (bool
                                                              value) async {
                                                            setState(() {
                                                              boolList[index] =
                                                                  value;
                                                              if (value) {
                                                                selectedGradientColors[
                                                                    index] = index %
                                                                            3 ==
                                                                        1
                                                                    ? color1
                                                                    : index % 3 ==
                                                                            2
                                                                        ? color2
                                                                        : color3;
                                                              } else {
                                                                selectedGradientColors
                                                                    .remove(
                                                                        index);
                                                              }
                                                            });
                                                            await updateRoomSwitchState(
                                                                catData.Key,
                                                                value);
                                                            print(boolList[
                                                                index]);
                                                          },
                                                          value:
                                                              boolList[index],
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 15),
                                                          child: Text(
                                                            boolList[index]
                                                                ? "ON"
                                                                : "OFF",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () async {
                                                            try {
                                                              await deleteDataFromFirebase(
                                                                  catData
                                                                      .Key); // Assuming you have a way to get the room ID
                                                              // Handle successful deletion
                                                            } catch (error) {
                                                              // Handle error
                                                            }
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete),
                                                        ),
                                                      ],
                                                    ),
                                                    //},
                                                    //),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ),
          ],
        ),
      );
    }

   

    return DefaultTabController(
      length: roomData.length + 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(231, 238, 250, 1),
          foregroundColor: Colors.black,
          title: Image.asset('assets/sync.png'),
          bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: const Color(0xFF152D5E)),
              indicatorColor: const Color.fromRGBO(231, 238, 250, 1),
              automaticIndicatorColorAdjustment: false,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              tabs: List.generate(roomData.length + 1, (index) {
                if (index == 0) {
                  return InkWell(
                    onLongPress: () {
                      setState(() {
                        roomData.add([]);
                      });
                    },
                    child: const SizedBox(
                        width: 100,
                        height: 30,
                        child: Icon(
                          Icons.add,
                        )),
                  );
                } else {
                  return SizedBox(
                    height: 40,
                    width: 100,
                    child: Center(
                        child: Text(
                      "Room $index",
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    )),
                  );
                }
              })),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  size: 30,
                )),
            IconButton(
                onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ProfileView();
                    })),
                icon: const Icon(
                  Icons.account_circle,
                  size: 30,
                )),
          ],
        ),
        drawer: MyDrawer(),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              color: const Color.fromRGBO(231, 238, 250, 1),
            ),
            TabBarView(
                children: List.generate(roomData.length + 1, (index) {
              if (index == 0) {
                return AllDevices();
              } else {
                return Room(index);
              }
            })),
          ],
        ),
      ),
    );
  }
}

class RoomData {
  var roomNo = "";
  var icon;
  var imageUrl = "";
  var onOf;
  var deviceName;
  var Key;
  RoomData(
      {required this.roomNo,
      required this.icon,
      required this.onOf,
      required this.imageUrl,
      required this.deviceName,
      required this.Key});
}*/
