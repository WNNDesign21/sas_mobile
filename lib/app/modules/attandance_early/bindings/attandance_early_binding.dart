import 'package:get/get.dart';

import '../controllers/attandance_early_controller.dart';

class AttandanceEarlyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttandanceEarlyController>(
      () => AttandanceEarlyController(),
    );
  }
}
