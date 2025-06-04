import 'package:get/get.dart';
import '../controllers/qr_controller.dart'; // Sesuaikan path dengan struktur proyek Anda

class ScanqrBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanqrController>(() => ScanqrController());
  }
}
