import 'package:get/get.dart';

import '../controllers/keamanan_view_controller.dart';

class KeamananViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeamananViewController>(
      () => KeamananViewController(),
    );
  }
}
