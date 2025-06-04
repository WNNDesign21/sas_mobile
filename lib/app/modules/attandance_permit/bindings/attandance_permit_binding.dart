import 'package:get/get.dart';

import '../controllers/attandance_permit_controller.dart';

class AttandancePermitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttandancePermitController>(
      () => AttandancePermitController(),
    );
  }
}
