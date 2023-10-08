import 'package:get/get.dart';

import '../controllers/biometricpage_controller.dart';

class BiometricpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiometricpageController>(
      () => BiometricpageController(),
    );
  }
}
