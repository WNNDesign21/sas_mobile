import 'package:flutter/material.dart';
import 'dart:ui'; // Import dart:ui for ImageFilter
import 'package:provider/provider.dart'; // Import provider
import 'package:sas_project/pages/dashboard.dart';
import 'package:sas_project/pages/setting.dart';
import '../controllers/profile_controller.dart'; // Import the controller
import 'package:google_fonts/google_fonts.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    // 🔹 Sidebar (Drawer)
    drawer: _buildDrawer(context),

    // 🔹 Header + Hamburger Menu
    body: Stack(
      children: [
        Column(
          children: <Widget>[
            _buildHeader(context),
          ],
        ),
      ],
    ),
  );
}

Widget _buildDrawer(BuildContext context) {
  return Drawer(
    width: 200, // Lebar sidebar tetap
    backgroundColor:
        Colors.transparent, // Make the drawer background transparent
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(0.3), // Adjust opacity for desired transparency level
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Increased blur
          child: Column(
            children: [
              SizedBox(height: 70),
              Image.asset(
                'assets/images/sidebar.png',
                width: 170,
              ),
              SizedBox(height: 50),
              ..._buildDrawerItems(context),
              Spacer(),
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    ),
  );
}

List<Widget> _buildDrawerItems(BuildContext context) {
  final List<Map<String, dynamic>> drawerItems = [
    {"icon": Icons.home, "title": "Home", "route": "/dashboard"},
    {"icon": Icons.person, "title": "Profile", "route": "/profile"},
    {"icon": Icons.check_circle, "title": "Attendance", "route": "/attendance"},
    {"icon": Icons.settings, "title": "Setting", "route": "/setting"},
  ];

  return drawerItems.map((item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 45, 28),
              Color.fromARGB(255, 205, 0, 0)
            ], // Warna gradient
            begin: Alignment.topCenter, // Gradient dari atas ke bawah
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          leading: Icon(item["icon"], color: Colors.white),
          title: Text(item["title"],
              style: GoogleFonts.balooBhai2(color: Colors.white)),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            if (item["route"] == "/profile") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileWidget()),
              );
            } else if (item["route"] == "/dashboard") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            } else if (item["route"] == "/setting") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingWidget()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Fitur ${item["title"]} belum tersedia')),
              );
            }
          },
        ),
      ),
    );
  }).toList();
}

Widget _buildLogoutButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 45, 28),
            Color.fromARGB(255, 205, 0, 0)
          ], // Warna gradient
          begin: Alignment.topCenter, // Gradient dari atas ke bawah
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        leading: Icon(Icons.logout, color: Colors.white),
        title:
            Text("Logout", style: GoogleFonts.balooBhai2(color: Colors.white)),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
    ),
  );
}

Widget _buildHeader(BuildContext context) {
  return Container(
    height: 120,
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
          Color.fromRGBO(151, 41, 54, 0.99),
          Color.fromRGBO(194, 0, 30, 1),
        ],
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 30,
          left: MediaQuery.of(context).size.width / 2 - 70,
          child: Column(
            children: [
              Text(
                'Profile',
                textAlign: TextAlign.center,
                style: GoogleFonts.balooBhai2(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 25,
          left: 20,
          child: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.white, size: 39),
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
            'assets/images/logosasputih.png', // Pastikan file ada di dalam assets
            width: 50,
            height: 50,
          ),
        ),
      ],
    ),
  );
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          // 🔹 Background Image with Opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, // Adjust opacity here (0.0 - 1.0)
              child: Image.asset(
                'assets/images/bgfix.png', // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              _buildHeader(context),
              _buildProfileCard(context), // ✅ Card Tetap
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildProfileContent(context), // ✅ Form Bisa Scroll
                    ],
                  ),
                ),
              ),
              _buildUploadEditSaveButtons(), // ✅ Tombol Tetap di Bawah
            ],
          ),
        ],
      ),
    );
  }

  /// ✅ Card Profil Tetap di Atas
  Widget _buildProfileCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Lebar mengikuti layar
      margin: EdgeInsets.all(35),
      padding: EdgeInsets.all(0), // Padding bisa diatur sesuai keinginan
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Gambar Profil
          Container(
            width: 180, // Sesuaikan dengan kebutuhan
            height: 180, // Sesuaikan tinggi
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/tangguh.png"),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          SizedBox(width: 16), // Jarak antara gambar dan teks

          // Kolom Informasi Profil
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo kecil di atas
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 180,
                    height: 50,
                  ),
                ),
                SizedBox(height: 8), // Jarak antara logo dan teks

                // Informasi Profil
                _buildProfileRow("Nama:", "Fajar Nur Farrijal"),
                _buildProfileRow("NPM:", "4337855201230105"),
                _buildProfileRow("Fakultas:", "Informatika"),
                _buildProfileRow("Valid:", "2023 - 2027"),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Fungsi untuk membuat baris informasi profil
  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 4),
          Text(value),
        ],
      ),
    );
  }

  /// ✅ Form Bisa Scroll
  Widget _buildProfileContent(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildTextField('Nama', profileController.namaController),
          _buildTextField('NPM', profileController.npmController),
          _buildTextField('Fakultas', profileController.fictController),
          _buildTextField('Email', profileController.emailController),
          _buildTextField('Nama ibu kandung', profileController.ibuController),
          _buildTextField('Agama', profileController.agamaController),
          _buildTextField('Alamat', profileController.alamatController),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  /// ✅ Tombol Upload, Edit, Simpan Tetap di Bawah
  Widget _buildUploadEditSaveButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          _buildUploadPhotoButton(),
          SizedBox(height: 10),
          _buildEditSaveButtons(),
        ],
      ),
    );
  }

  Widget _buildUploadPhotoButton() {
    return GestureDetector(
      onTap: () {
        // Handle image upload logic here
      },
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, color: Colors.red),
            SizedBox(width: 5),
            Text(
              'Upload foto',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditSaveButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton("Edit", Colors.black),
        _buildButton("Simpan", Colors.red),
      ],
    );
  }

  Widget _buildButton(String title, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  /// ✅ Input Field
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: label,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
