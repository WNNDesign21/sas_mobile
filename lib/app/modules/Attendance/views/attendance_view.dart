import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widget/sidebar_widget.dart'; // Import SidebarWidget
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarWidget(), // Menggunakan Sidebar dari widget
      body: Stack(
        children: <Widget>[
          // 🔹 Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/bgfix.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 Header
          _buildHeader(context),

          // 🔹 Konten
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                // 🔹 Judul "Mata Kuliah"
                Text(
                  'Mata Kuliah',
                  style: GoogleFonts.balooBhai2(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Daftar Mata Kuliah
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildSubjectButton('Pemrograman Web'),
                      _buildSubjectButton('Pemrograman Mobile'),
                      _buildSubjectButton('Isad 2'),
                      _buildSubjectButton('Statistik'),
                      _buildSubjectButton('Mobile Project'),
                      _buildSubjectButton('Office App'),
                      _buildSubjectButton('GWEP 4'),
                      _buildSubjectButton('Java OOP'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Header
  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(53),
          bottomRight: Radius.circular(53),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(79, 1, 2, 0.99),
            Color.fromRGBO(151, 41, 54, 0.99),
            Color.fromRGBO(194, 0, 30, 1),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 60,
            left: MediaQuery.of(context).size.width / 2 - 70,
            child: Text(
              'Attendance',
              textAlign: TextAlign.center,
              style: GoogleFonts.balooBhai2(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 25,
            left: 20,
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 39),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 30,
            child: Image.asset(
              'assets/images/logosasputih.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Widget untuk Tombol Mata Kuliah
  Widget _buildSubjectButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            shadowColor: Colors.black.withOpacity(0.2),
            elevation: 7,
          ),
          onPressed: () {
            // Navigasi ke halaman detail jika diperlukan
            Get.snackbar("Info", "Navigasi ke $title",
                backgroundColor: Colors.blue, colorText: Colors.white);
          },
          child: Text(
            title,
            style: GoogleFonts.balooBhai2(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}
