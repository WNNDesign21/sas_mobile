import 'package:flutter/material.dart';
import 'dart:ui'; // Import dart:ui for ImageFilter
import 'package:provider/provider.dart'; // Import provider

import '../controllers/profile_controller.dart'; // Import the controller

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildProfileContent(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      width: 200,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
      {
        "icon": Icons.check_circle,
        "title": "Attendance",
        "route": "/attendance"
      },
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
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListTile(
            leading: Icon(item["icon"], color: Colors.white),
            title: Text(item["title"], style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              if (item["route"] == "/profile") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileWidget()),
                );
              } else if (item["route"] == "/dashboard") {
                Navigator.pushReplacementNamed(context, '/dashboard');
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
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          leading: Icon(Icons.logout, color: Colors.white),
          title: Text("Logout", style: TextStyle(color: Colors.white)),
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
            top: 60,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Text(
              'Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
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
              'assets/images/logosasputih.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    final profileController =
        Provider.of<ProfileController>(context); //get the profileController
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40),
          _buildProfileTextFields(profileController), // Pass the controller
          SizedBox(height: 60), // Increased space here
          _buildUploadPhotoButton(profileController), // Pass the controller
          SizedBox(height: 20), // Increased space here
          _buildEditSaveButtons(profileController), // Pass the controller
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildEditSaveButtons(ProfileController profileController) {
    return Container(
      width: 272,
      height: 42,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 143,
            child: InkWell(
              onTap: () {
                // Handle save logic here, call profileController.saveProfileData()
                profileController.saveProfileData();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Simpan clicked!')),
                );
              },
              child: Container(
                width: 129,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  gradient: LinearGradient(
                    begin: Alignment(6.123234262925839e-17, 1),
                    end: Alignment(-1, 6.123234262925839e-17),
                    colors: [
                      Color.fromRGBO(255, 45, 28, 1),
                      Color.fromRGBO(205, 0, 0, 1),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Simpan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Baloo Bhai',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                // Handle Edit logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Edit clicked!')),
                );
              },
              child: Container(
                width: 129,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  color: Color.fromRGBO(91, 6, 0, 1),
                ),
                child: Center(
                  child: Text(
                    'Edit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Baloo Bhai',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      height: 1,
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

  Widget _buildUploadPhotoButton(ProfileController profileController) {
    return GestureDetector(
      onTap: () {
        // Handle image upload using the profileController
        profileController.pickImage();
      },
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Color.fromRGBO(255, 255, 255, 1),
          border: Border.all(
            color: Color.fromRGBO(133, 127, 127, 1),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined,
                color: const Color.fromARGB(255, 231, 8, 8)),
            SizedBox(width: 5),
            Text(
              'Upload foto',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Baloo 2',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTextFields(ProfileController profileController) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildTextField('Nama Lengkap', profileController.namaController),
          SizedBox(height: 40), // Reduced space between fields
          _buildTextField('NPM', profileController.npmController),
          SizedBox(height: 40), // Reduced space between fields
          _buildTextField('No Hp', profileController.noHpController),
          SizedBox(height: 40), // Reduced space between fields
          _buildTextField('Email', profileController.emailController),
          SizedBox(height: 40), // Reduced space between fields
          _buildTextField('Alamat', profileController.alamatController),
          SizedBox(height: 40), // Reduced space between fields
          _buildTextField('FICT/Informatika', profileController.fictController),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      height: 49,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.6700000166893005),
        border: Border.all(
          color: Color.fromRGBO(133, 127, 127, 1),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: TextFormField(
          controller: controller, // Use the provided controller
          decoration: InputDecoration(
            hintText: label, // Use label as hint text
            hintStyle: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.41999998688697815),
              fontFamily: 'Baloo 2',
              fontSize: 18,
              fontWeight: FontWeight.normal,
              height: 1,
            ),
            border: InputBorder.none, // Remove the default border
          ),
          style: TextStyle(
            color: Colors.black, // Text color when typing
            fontFamily: 'Baloo 2',
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
