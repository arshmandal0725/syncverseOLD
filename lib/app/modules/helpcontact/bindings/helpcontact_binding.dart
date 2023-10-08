import 'package:get/get.dart';

import '../controllers/helpcontact_controller.dart';

class HelpcontactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpcontactController>(
      () => HelpcontactController(),
    );
  }
}
