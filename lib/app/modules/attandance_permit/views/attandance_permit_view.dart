import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widget/sidebar_widget.dart'; // Import SidebarWidget
import '../../widget/profile_widget.dart';

import '../controllers/attandance_permit_controller.dart';

class AttandancePermitView extends GetView<AttandancePermitController> {
  const AttandancePermitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarWidget(),

      body: Stack(
        children: <Widget>[
          // 🔹 Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset('assets/images/bgfix.png', fit: BoxFit.cover),
            ),
          ),
          // 🔹 Header
          _buildHeader(context),

          // 🔹 Content
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                // Tampilkan judul form
                Text(
                  'Permit Letter', // Menampilkan subjectTitle yang diterima
                  style: GoogleFonts.balooBhai2(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),

                Container(
                  width: 350, // Mengatur lebar TextField
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start, // Menyusun konten secara vertikal
                    children: [
                      // **Input Fields**
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'NPM',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Fakultas',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Keterangan',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // **Upload Photo Button**
                // ElevatedButton.icon(
                //   onPressed: () {
                //     // Implement your photo upload functionality here
                //   },
                //   icon: const Icon(Icons.upload_file),
                //   label: const Text('Upload Photo'),
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(vertical: 15),
                //     backgroundColor: Colors.blue,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     elevation: 5,
                //   ),
                // ),
                // const SizedBox(height: 20),

                // // **Send Button**
                // ElevatedButton(
                //   onPressed: () {
                //     // Implement your send functionality here
                //   },
                //   child: const Text('Send'),
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(vertical: 15),
                //     backgroundColor: Colors.red,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     elevation: 5,
                //   ),
                // ),
                Positioned(
                  bottom: 35,
                  left: 0,
                  right: 0,
                  child: Center(child: Column(children: [SaveButton()])),
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
      height: 110,
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
            top: 48,
            left: MediaQuery.of(context).size.width / 2 - 79,
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
            top: 40,
            left: 20,
            child: Builder(
              builder:
                  (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white, size: 39),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
            ),
          ),
          Positioned(
            top: 47,
            right: 30,
            child: Image.asset(
              'assets/images/logosasputih.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
