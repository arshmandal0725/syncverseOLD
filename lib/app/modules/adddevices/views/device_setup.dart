import 'package:flutter/material.dart';

class DeviceSetup extends StatefulWidget {
  const DeviceSetup({super.key});

  @override
  State<DeviceSetup> createState() => _DeviceSetupState();
}

class _DeviceSetupState extends State<DeviceSetup> {
  Widget textLine(String title, String textButtonTitle) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                textButtonTitle,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepOrange),
              ))
        ],
      ),
    );
  }

  Widget textfield(String title, Icon icon) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: title, suffixIcon: icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Text('Setup a Device'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              textLine('Choose Device', 'Add Manually'),
              textfield('WSD_Honeywell', Icon(Icons.refresh)),
              textLine('Choose WiFi', 'Add Manually'),
              textfield('SW_Honeywell', Icon(Icons.refresh)),
              textLine('Wifi Password', ''),
              textfield("HOneywell2021", Icon(Icons.remove_red_eye)),
              textLine('Location', 'Add Location'),
              textfield('home', Icon(Icons.refresh)),
              textLine('Device name', ''),
              textfield('Enter Device name', Icon(Icons.device_hub)),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 160,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Center(
                        child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 17),
                    )),
                  ),
                  Container(
                    height: 40,
                    width: 160,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Center(
                        child: Text(
                      'Connect',
                      style: TextStyle(fontSize: 17),
                    )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
