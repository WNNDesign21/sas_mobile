import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanqrWidget extends StatefulWidget {
  @override
  _ScanqrWidgetState createState() => _ScanqrWidgetState();
}

class _ScanqrWidgetState extends State<ScanqrWidget> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 🔹 Kamera Scanner
          MobileScanner(
            controller: cameraController,
            fit: BoxFit.cover, // Kamera full screen
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('Barcode ditemukan! Data: ${barcode.rawValue}');
                // ✅ Navigasi atau lakukan sesuatu saat QR code terdeteksi
                Navigator.pop(context, barcode.rawValue);
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
              decoration: BoxDecoration(
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
            top: screenSize.height * 0.03,
            left: screenSize.width * 0.05,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 39),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // 🔹 Kotak Fokus QR Scanner
          Positioned(
            top: screenSize.height * 0.3,
            left: screenSize.width * 0.15,
            child: Container(
              width: screenSize.width * 0.7,
              height: screenSize.width * 0.7,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(Icons.qr_code, color: Colors.white, size: 60),
              ),
            ),
          ),

          // 🔹 Tombol Flash & Kamera Switch
          Positioned(
            bottom: 100,
            left: screenSize.width * 0.3,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.flash_on, color: Colors.white, size: 35),
                  onPressed: () {
                    cameraController.toggleTorch();
                  },
                ),
                SizedBox(width: 40),
                IconButton(
                  icon: Icon(Icons.cameraswitch, color: Colors.white, size: 35),
                  onPressed: () {
                    cameraController.switchCamera();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
