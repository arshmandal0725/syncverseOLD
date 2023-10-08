import 'package:flutter/material.dart';
import 'package:syncverse/app/modules/wifi_connection.dart/wifi_password.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:wifi_info_plugin_plus/wifi_info_plugin_plus.dart';

class WifiList extends StatefulWidget {
  const WifiList({super.key});

  @override
  State<WifiList> createState() => _WifiListState();
}

List<WifiNetwork> wifiList = [];
String ipv4 = '';

class _WifiListState extends State<WifiList> {
  void printWifiNames() async {
    // Check if Wi-Fi is enabled
    bool isWifiEnabled = await WiFiForIoTPlugin.isEnabled();

    if (isWifiEnabled) {
      // Scan for available Wi-Fi networks
      wifiList = await WiFiForIoTPlugin.loadWifiList();
    }
  }

  void getWifiIPv4Address() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi) {
      try {
        final wifiInfo = await WifiInfoPlugin.wifiDetails;
        ipv4 = wifiInfo!.dns1;
      } catch (e) {
        print('not working');
      }
    } else {}
  }

  @override
  void initState() {
    printWifiNames();
    getWifiIPv4Address();
    super.initState();
  }

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
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Center(
          child: Column(
            children: [
              const Center(
                child: Text(
                  'WiFi List',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: wifiList.length,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) {
                            return EnterPassword(
                              ssid: wifiList[index],
                              ipvp4: ipv4,
                            );
                          }));
                        },
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              height: 50,
                              width: double.infinity,
                              child: Center(
                                child: Text('${wifiList[index].ssid}'),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
