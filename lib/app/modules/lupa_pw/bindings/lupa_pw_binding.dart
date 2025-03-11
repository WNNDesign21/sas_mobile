import 'package:get/get.dart';

import '../controllers/lupa_pw_controller.dart';

class LupaPwBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LupaPwController>(
      () => LupaPwController(),
    );
  }
}
