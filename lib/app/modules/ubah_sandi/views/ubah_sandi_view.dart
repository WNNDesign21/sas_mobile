import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import '../controllers/ubah_sandi_controller.dart';

class UbahSandiView extends GetView<UbahSandiController> {
  const UbahSandiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset('assets/images/bgfix.png', fit: BoxFit.cover),
            ),
          ),

          // Header
          _buildHeader(context),

          // Form Ubah Kata Sandi
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, -50),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Judul
                      Text(
                        'Ubah Kata Sandi',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.balooBhai2(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Input Password Saat Ini
                      TextFormField(
                        controller: controller.currentPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password saat ini',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Lupa Password
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: TextButton(
                      //     onPressed: () {
                      //       Get.snackbar(
                      //         'Info',
                      //         'Fitur lupa password belum tersedia',
                      //       );
                      //     },
                      //     child: Text(
                      //       'Lupa Password?',
                      //       style: GoogleFonts.balooBhai2(
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.red,
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // Input Password Baru
                      TextFormField(
                        controller: controller.newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password baru',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Input Konfirmasi Password Baru
                      TextFormField(
                        controller: controller.confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Ulang Password Baru',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 45, 28),
                              Color.fromARGB(255, 205, 0, 0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextButton(
                          onPressed: controller.changePassword,
                          child: Text(
                            'Simpan',
                            style: GoogleFonts.balooBhai2(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Header
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
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Text(
              'Setting',
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
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 39,
                    ),
                    onPressed: () {
                      Get.back();
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
