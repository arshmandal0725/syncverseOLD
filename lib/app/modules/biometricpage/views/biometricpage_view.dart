import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:syncverse/app/modules/biometricpage/views/succes.dart';

class BiometricpageView extends StatefulWidget {
  BiometricpageView({Key? key}) : super(key: key);

  @override
  _BiometricpageViewState createState() => _BiometricpageViewState();
}

class _BiometricpageViewState extends State<BiometricpageView> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _supportState = isSupported;
        }));
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Kindly give fingerprint',
          options:
              AuthenticationOptions(stickyAuth: true, biometricOnly: true));
      print("Authentication result: $authenticated");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return SuccessB();
      }));
    } on PlatformException catch (e) {
      print("Error during authentication: $e");
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    print("Available biometrics: $availableBiometrics");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BiometricpageView'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_supportState)
              const Text('Device Supported')
            else
              Text('Not Supported'),
            const Divider(
              height: 100,
            ),
            ElevatedButton(
              onPressed: _getAvailableBiometrics,
              child: const Text('Getting Biometrics'),
            ),
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text('Authenticate'),
            ),
          ],
        ),
      ),
    );
  }
}
