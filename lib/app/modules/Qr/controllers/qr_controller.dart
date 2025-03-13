import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanqrController extends GetxController {
  MobileScannerController cameraController = MobileScannerController();
  final isFlashOn = false.obs;
  final isFrontCamera = false.obs;

  void toggleFlash() {
    cameraController.toggleTorch();
    isFlashOn.value = !isFlashOn.value;
  }

  void switchCamera() {
    cameraController.switchCamera();
    isFrontCamera.value = !isFrontCamera.value;
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
