import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/lupa_pw_controller.dart';

class LupaPwView extends GetView<LupaPwController> {
  const LupaPwView({super.key});

  @override
  Widget build(BuildContext context) {
    // Menentukan ukuran card yang konsisten
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          //🔹 Background Gambar
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgloginfix.png',
              fit: BoxFit.cover,
            ),
          ),
          // 🔹 Konten Reset Password
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Transform.translate(
                    offset: const Offset(0, -70), // Geser ke atas
                    child: Container(
                      width:
                          screenWidth * 0.85, // Set lebar card agar konsisten
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white.withOpacity(0.8), // Transparansi
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ], // BoxShadow
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Judul
                          Text(
                            'Reset Password',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.balooBhai2(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 50),
                          // Input Email
                          TextFormField(
                            controller: controller.MasukanEmailController,
                            decoration: InputDecoration(
                              labelText: 'Masukkan Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),

                          // Tombol Send OTP dengan Gradient
                          Container(
                            width: double.infinity,
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
                            child: Obx(
                              () => ElevatedButton(
                                onPressed:
                                    controller.isLoading.value
                                        ? null // Tombol disable saat loading
                                        : () async {
                                          await controller.sendOTP();
                                        },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 50,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  // Menambahkan style untuk state disabled
                                  disabledBackgroundColor: Colors.grey
                                      .withOpacity(0.5),
                                ),
                                child:
                                    controller.isLoading.value
                                        ? const SizedBox(
                                          height: 24, // Sesuaikan tinggi
                                          width: 24, // Sesuaikan lebar
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3, // Ketebalan garis
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                        : Text(
                                          'Send OTP',
                                          style: GoogleFonts.balooBhai2(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
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
            ),
          ),
        ],
      ),
    );
  }
}
