import 'package:flutter/material.dart';

class ScanqrWidget extends StatefulWidget {
  @override
  _ScanqrWidgetState createState() => _ScanqrWidgetState();
}

class _ScanqrWidgetState extends State<ScanqrWidget> {
  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Header dengan Gradient dan Rounded Corners
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: screenSize.width, // Menggunakan lebar layar
              height: screenSize.height *
                  0.15, // Menggunakan persentase tinggi layar
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(53),
                  bottomRight: Radius.circular(53),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(79, 1, 2, 0.99),
                    Color.fromRGBO(151, 41, 54, 0.995),
                    Color.fromRGBO(194, 0, 30, 1),
                  ],
                ),
              ),
            ),
          ),
          // Ikon Menu menggunakan IconButton dan Icon bawaan Flutter
          Positioned(
            top: screenSize.height * 0.03, // Posisi relatif dari tinggi layar
            left: screenSize.width * 0.05, // Posisi relatif dari lebar layar
            child: IconButton(
              icon: Icon(Icons.menu,
                  color: Colors.white, size: 39), // Menggunakan Icons.menu
              onPressed: () {
                // Tambahkan fungsi untuk menangani klik ikon menu di sini
                print('Ikon menu diklik');
              },
            ),
          ),
          // Overlay Gelap
          Container(
            width: screenSize.width,
            height: screenSize.height,
            color: Color.fromRGBO(0, 0, 0, 0.5),
          ),
          // Kotak QR Code
          Positioned(
            top: screenSize.height * 0.35, // Posisi relatif dari tinggi layar
            left: screenSize.width * 0.2, // Posisi relatif dari lebar layar
            child: Container(
              width:
                  screenSize.width * 0.6, // Menggunakan persentase lebar layar
              height:
                  screenSize.width * 0.6, // Menggunakan persentase lebar layar
              decoration: BoxDecoration(
                color: Color.fromRGBO(217, 217, 217, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
