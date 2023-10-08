import 'package:flutter/material.dart';

import '../../profile/views/profile_view.dart';

class ScanQr extends StatelessWidget {
  const ScanQr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_active_outlined,
                size: 30,
              )),
          IconButton(
              onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ProfileView();
                  })),
              icon: const Icon(
                Icons.account_circle,
                size: 30,
              )),
        ],
        elevation: 0,
        backgroundColor: const Color.fromRGBO(231, 238, 250, 1),
        foregroundColor: Colors.black,
        title: Image.asset('assets/sync.png'),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(231, 238, 250, 1),
          ),
          Column(children: [
            Center(
              child: Container(
                color: Colors.white70,
                height: 300,
                width: 300,
                child: Image.asset("assets/images/bx_qr.jpg"),
              ),
            ),
            SizedBox(
              width: 300,
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                color: const Color(0xFF152D5E),
                margin: const EdgeInsets.all(10),
                child: TextButton(
                  style: TextButton.styleFrom(),
                  onPressed: () {},
                  child: const Text(
                    "Proceed",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
