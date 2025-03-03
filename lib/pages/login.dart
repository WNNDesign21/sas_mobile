import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/login_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

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
          // Positioned(
          //   right: 0, // Pindahkan ke paling kiri
          //   bottom: 0, // Pindahkan ke paling bawah
          //   child: Container(
          //     width:
          //         MediaQuery.of(context).size.width * 1, // Hanya setengah layar
          //     height: MediaQuery.of(context).size.height *
          //         1, // Atur tinggi agar sesuai
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage('images/bg.png'),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),

          // 🔹 Konten Login
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 🔹 Logo (Dinaikkan dengan Transform)
                      // Transform.translate(
                      //   offset: Offset(0, -70), // Geser ke atas
                      //   child: Image.asset(
                      //     'images/logo.png',
                      //     width: 200,
                      //     height: 80,
                      //     fit: BoxFit.fitWidth,
                      //   ),
                      // ),
                      Transform.translate(
                        offset: Offset(0, -120), // Geser ke atas
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 300,
                          fit: BoxFit.fitWidth,
                        ),
                      ),

                      SizedBox(height: 30), // Jarak antar elemen

                      // 🔹 Card untuk form login (Dinaikkan dengan Transform)
                      Transform.translate(
                        offset: Offset(0, -70), // Geser ke atas
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
                                offset: Offset(0, 4),
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
                              SizedBox(height: 20),

                              // Input NPM
                              TextFormField(
                                controller: loginController.npmController,
                                decoration: InputDecoration(
                                  labelText: 'NPM',
                                  prefixIcon: Icon(Icons.person_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              // Input Password
                              TextFormField(
                                controller: loginController.passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              // 🔹 Menampilkan pesan error jika login gagal
                              if (loginController.errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    loginController.errorMessage!,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),

                              // 🔹 Tombol Login dengan Gradient
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
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
                                  onPressed: loginController.isLoading
                                      ? null
                                      : () {
                                          loginController.login(context);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: loginController.isLoading
                                      ? CircularProgressIndicator(
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
                                        ),
                                ),
                              ),

                              SizedBox(height: 10),

                              // 🔹 Lupa Password
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
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
