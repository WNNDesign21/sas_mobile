import 'dart:ui';
import 'package:flutter/material.dart';
import 'profile.dart'; // Import untuk header dan sidebar
import 'package:sas_project/pages/dashboard.dart';

class SettingWidget extends StatefulWidget {
  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context), // Menggunakan Sidebar dari profile.dart
      body: Stack(
        children: <Widget>[
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, // Adjust opacity here (0.0 - 1.0)
              child: Image.asset(
                'assets/images/bgfix.png', // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Header
          _buildHeader(context), // Menggunakan Header dari profile.dart
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                // Keamanan
                _buildSettingItem(
                  title: 'Keamanan',
                  icon: Icons.security,
                  onTap: () {
                    // Aksi ketika Keamanan diklik
                  },
                ),
                _buildDivider(), // Divider antara item

                // Pusat Bantuan
                _buildSettingItem(
                  title: 'Pusat Bantuan',
                  icon: Icons.help_outline,
                  onTap: () {
                    // Aksi ketika Pusat Bantuan diklik
                  },
                ),
                _buildDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

//sidebar
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

  //header
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
              'Setting',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileWidget()),
                );
              } else if (item["route"] == "/dashboard") {
                Navigator.push(
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

  // Item Pengaturan (Keamanan, Pusat Bantuan)
  Widget _buildSettingItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, size: 44),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Baloo 2',
                fontSize: 24,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  // Divider
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      child: Divider(
        color: Color.fromRGBO(133, 127, 127, 1),
        thickness: 1.7,
      ),
    );
  }
}
