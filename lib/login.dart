import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background dengan Rotasi & Bisa Diatur Posisi & Ukurannya
          Positioned.fill(
            child: Image.asset(
              'images/bgloginfix.png', // Pastikan path sesuai dengan aset
              fit: BoxFit.cover, // Bisa diganti menjadi contain, fill, dll.
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
                      // Logo
                      Image.asset(
                        'images/logo.png', // Pastikan path benar
                        width: 200,
                        height: 80,
                        fit: BoxFit.fitWidth,
                      ),

                      SizedBox(height: 20),

                      // Card untuk form login
                      Container(
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
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Baloo Bhai',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Input NPM
                            TextFormField(
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

                            // Tombol Login
                            ElevatedButton(
                              onPressed: () {
                                // Tambahkan fungsi login di sini
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 173, 26, 26),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'Baloo Bhai',
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            // Lupa Password
                            TextButton(
                              onPressed: () {
                                // Tambahkan fungsi lupa password di sini
                              },
                              child: Text(
                                'Lupa Password?',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: const Color.fromARGB(221, 0, 0, 0),
                                  fontFamily: 'Baloo Bhai',
                                ),
                              ),
                            ),
                          ],
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
