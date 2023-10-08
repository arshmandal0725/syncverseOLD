import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
   FaqView({Key? key}) : super(key: key);

  bool _customIcon = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        backgroundColor: Color(0xFF264A7E),
      ),
      body: Center(
        child: Column(
          children: [
            ExpansionTile(
              title: Text('Expansion Tile'),
              trailing: Icon(_customIcon
                  ? Icons.arrow_drop_down_circle
                  : Icons.arrow_drop_down),
              children: [
                ListTile(
                  title: Text('This is tile number'),
                )
              ],
              onExpansionChanged: (bool expanded) {
                // setState(() {
                  _customIcon = expanded;
                // });
              },
            ),
          ],
        ),
      ),
    );
  }
}
