import 'package:get/get.dart';

import '../controllers/attandace_subjectbutton_controller.dart';

class AttandaceSubjectbuttonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttandaceSubjectbuttonController>(
      () => AttandaceSubjectbuttonController(),
    );
  }
}
