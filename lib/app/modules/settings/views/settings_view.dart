import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart'; // Sesuaikan path
import '../../widget/sidebar_widget.dart'; // Import SidebarWidget
import 'package:google_fonts/google_fonts.dart';
import '../controllers/settings_controller.dart'; //import controller

class SettingsView extends GetView<SettingsController> {
  //gunakan GetView
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarWidget(), // Menggunakan Sidebar dari widget
      body: Stack(
        children: <Widget>[
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, // Adjust opacity here (0.0 - 1.0)
              child: Image.asset(
                'images/bgfix.png', // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Header
          _buildHeader(context),
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
                    Get.snackbar('Keamanan', 'Fitur keamanan belum tersedia');
                  },
                ),
                _buildDivider(), // Divider antara item

                // Pusat Bantuan
                _buildSettingItem(
                  title: 'Pusat Bantuan',
                  icon: Icons.help_outline,
                  onTap: () {
                    // Aksi ketika Pusat Bantuan diklik
                    Get.snackbar(
                        'Pusat Bantuan', 'Fitur pusat bantuan belum tersedia');
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

  //header
  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 120,
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
            top: 60,
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
            top: 25,
            left: 20,
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 39),
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
              'images/logosasputih.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
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
            const SizedBox(width: 20),
            Text(
              title,
              style: GoogleFonts.balooBhai2(
                fontSize: 24,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  // Divider
  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      child: Divider(
        color: Color.fromRGBO(133, 127, 127, 1),
        thickness: 1.7,
      ),
    );
  }
}
