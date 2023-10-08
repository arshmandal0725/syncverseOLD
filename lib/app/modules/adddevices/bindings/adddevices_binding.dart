import 'package:get/get.dart';

import '../controllers/adddevices_controller.dart';

class AdddevicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdddevicesController>(
      () => AdddevicesController(),
    );
  }
}
