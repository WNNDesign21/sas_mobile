import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanqrController extends GetxController {
  MobileScannerController cameraController = MobileScannerController();

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
