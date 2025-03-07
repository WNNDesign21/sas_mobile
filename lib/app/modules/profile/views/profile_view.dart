import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/sidebar_widget.dart'; // Import sidebar widget
import '../controllers/profile_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widget/profile_widget.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarWidget(), // Gunakan widget sidebar
      body: Stack(
        children: [
          // 🔹 Background Image with Opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, // Adjust opacity here (0.0 - 1.0)
              child: Image.asset(
                'images/bgfix.png', // Replace with your image path
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

  /// ✅ Card Profil Tetap di Atas
  Widget _buildProfileCard(BuildContext context) {
    return const ProfileCardWidget();
  }

  /// ✅ Form Bisa Scroll
  Widget _buildProfileContent(BuildContext context) {
    return const ProfileContentWidget();
  }

  /// ✅ Tombol Upload, Edit, Simpan Tetap di Bawah
  Widget _buildUploadEditSaveButtons() {
    return const ProfileButtonWidget();
  }
}
