import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar Custom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Nama User
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome,",
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      Text(
                        "Wendi Nugraha N",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  // Tombol Logout
                  IconButton(
                    icon: Icon(Icons.logout, color: Colors.red),
                    onPressed: () {
                      // Fungsi Logout
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Card Informasi Utama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Smart Attendance Student",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Statistik kehadiran terbaru Anda",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Grafik Statistik
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/chart.png', // Ganti dengan path grafik Anda
                    width: 250,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Menu Navigasi
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.symmetric(horizontal: 20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildMenuItem("Presensi", Icons.check_circle, Colors.blue),
                  _buildMenuItem("Jadwal", Icons.calendar_today, Colors.green),
                  _buildMenuItem("Tugas", Icons.assignment, Colors.orange),
                  _buildMenuItem("Profile", Icons.person, Colors.purple),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk Menu Item
  Widget _buildMenuItem(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: color),
          SizedBox(height: 10),
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
