import 'package:flutter/material.dart';
import 'package:syncverse/app/modules/wifi_connection.dart/wifi_list.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:web_socket_channel/io.dart';

class EnterPassword extends StatefulWidget {
  const EnterPassword({super.key, required this.ssid, required this.ipvp4});

  final WifiNetwork ssid;
  final String ipvp4;

  @override
  State<EnterPassword> createState() => _EnterPasswordState();
}

void connectToWifi(String ssid, String pw, BuildContext context) async {
  bool isConnected = await WiFiForIoTPlugin.connect(ssid, password: pw);

  if (isConnected) {
    // Password is correct, proceed to store Wi-Fi name and password
    sendWifiCredentialsToServer(ssid, pw, ipv4);
    Navigator.pop(context);
  } else {
    // Password is incorrect, handle the error accordingly
  }
}

void sendWifiCredentialsToServer(String ssid, String password, String ipvp4) {
  final channel = IOWebSocketChannel.connect('ws://$ipvp4:80');

  channel.sink.add('{"ssid": "$ssid", "password": "$password"}');

  // Don't forget to close the WebSocket connection when done
  channel.sink.close();
}

TextEditingController passWordController = TextEditingController();

class _EnterPasswordState extends State<EnterPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(231, 238, 250, 1),
        foregroundColor: Colors.black,
        title: Image.asset(
          'assets/SV.png',
          height: 20,
        ),
      ),
      backgroundColor: const Color.fromRGBO(231, 238, 250, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: passWordController,
            ),
            ElevatedButton(
                onPressed: () {
                  sendWifiCredentialsToServer(
                      '${widget.ssid}', passWordController.text, widget.ipvp4);
                  connectToWifi(
                      '${widget.ssid}', passWordController.text, context);
                },
                child: const Text('Submit')),
            Text(widget.ipvp4)
          ],
        ),
      ),
    );
  }
}
