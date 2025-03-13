import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../controllers/qr_controller.dart'; // Sesuaikan dengan path yang benar

class ScanqrWidget extends GetView<ScanqrController> {
  const ScanqrWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // State untuk menandai apakah qr sudah discan
    final RxBool _isQrScanned = false.obs;

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // Jika QR belum discan, berikan nilai null
          if (!_isQrScanned.value) {
            Get.back(result: null);
          }
          return true;
        },
        child: Stack(
          children: <Widget>[
            // 🔹 Kamera Scanner
            MobileScanner(
              controller: controller.cameraController,
              fit: BoxFit.cover, // Kamera full screen
              onDetect: (capture) async {
                try {
                  final List<Barcode> barcodes = capture.barcodes;
                  for (final barcode in barcodes) {
                    debugPrint('Barcode ditemukan! Data: ${barcode.rawValue}');
                    // Update state dan kirim data
                    if (!_isQrScanned.value) {
                      _isQrScanned.value = true;
                      await Future.delayed(const Duration(
                          milliseconds:
                              100)); // Delay sebelum mengembalikan nilai
                      Get.back(result: barcode.rawValue);
                    }
                  }
                } catch (e, stackTrace) {
                  // Tangani error
                  print('Error in onDetect: $e');
                  print('Stack Trace: $stackTrace');
                  //jika ada error, berikan data null
                  if (!_isQrScanned.value) {
                    _isQrScanned.value = true;
                    await Future.delayed(const Duration(milliseconds: 100));
                    Get.back(result: null);
                  }
                }
              },
            ),

            // 🔹 Overlay Transparan
            Container(
              width: screenSize.width,
              height: screenSize.height,
              color: Colors.black.withOpacity(0.3),
            ),

            // 🔹 Header Gradient
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: screenSize.width,
                height: screenSize.height * 0.15,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(53),
                    bottomRight: Radius.circular(53),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4F0102),
                      Color(0xFF971536),
                      Color(0xFFC2001E),
                    ],
                  ),
                ),
              ),
            ),

            // 🔹 Tombol Menu di Kiri Atas
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: screenSize.width * 0.05,
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 39),
                onPressed: () {
                  //jika qr belum di scan, maka kembalikan nilai null
                  if (!_isQrScanned.value) {
                    Get.back(result: null);
                  }
                },
              ),
            ),

            // 🔹 Kotak Fokus QR Scanner
            Center(
              child: Container(
                width: screenSize.width * 0.7,
                height: screenSize.width * 0.7,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.qr_code, color: Colors.white, size: 60),
                ),
              ),
            ),

            // 🔹 Tombol Flash & Kamera Switch
            Positioned(
              bottom: screenSize.height * 0.15,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => IconButton(
                      icon: Icon(
                        controller.isFlashOn.value
                            ? Icons.flash_on
                            : Icons.flash_off,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        controller.toggleFlash();
                      },
                    ),
                  ),
                  const SizedBox(width: 40),
                  Obx(
                    () => IconButton(
                      icon: Icon(
                        controller.isFrontCamera.value
                            ? Icons.camera_front
                            : Icons.camera_rear,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        controller.switchCamera();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
