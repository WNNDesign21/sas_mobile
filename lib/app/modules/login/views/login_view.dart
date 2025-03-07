import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';
import '../../../routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //🔹 Background Gambar
          Positioned.fill(
            child: Image.asset(
              'images/bgloginfix.png',
              fit: BoxFit.cover,
            ),
          ),
          // 🔹 Konten Login
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -120), // Geser ke atas
                        child: Image.asset(
                          'images/logo.png',
                          width: 300,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(height: 30), // Jarak antar elemen

                      // 🔹 Card untuk form login (Dinaikkan dengan Transform)
                      Transform.translate(
                        offset: const Offset(0, -70), // Geser ke atas
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white.withOpacity(0.8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Judul
                              Text(
                                'Sign in',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.balooBhai2(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Input NPM
                              TextFormField(
                                controller: controller.npmController,
                                decoration: InputDecoration(
                                  labelText: 'NPM',
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Input Password
                              TextFormField(
                                controller: controller.passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // 🔹 Menampilkan pesan error jika login gagal
                              Obx(
                                () => controller.errorMessage.value != null
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          controller.errorMessage.value!,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      )
                                    : const SizedBox
                                        .shrink(), // Menyembunyikan jika tidak ada error
                              ),
                              // 🔹 Tombol Login dengan Gradient
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 45, 28),
                                      Color.fromARGB(255, 205, 0, 0)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: ElevatedButton(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : () {
                                          controller.login();
                                        },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Obx(() => controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        )
                                      : Text(
                                          'Login',
                                          style: GoogleFonts.balooBhai2(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        )),
                                ),
                              ),

                              const SizedBox(height: 10),

                              // 🔹 Lupa Password
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Fitur Lupa Password Belum Tersedia'),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Lupa Password?',
                                  style: GoogleFonts.balooBhai2(
                                    fontSize: 16,
                                    color: const Color.fromARGB(221, 0, 0, 0),
                                  ),
                                ),
                              ),
                            ],
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
}
