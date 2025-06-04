import 'package:get/get.dart';

import '../controllers/attandance_check_controller.dart';

class AttandanceCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttandanceCheckController>(
      () => AttandanceCheckController(),
    );
  }
}
