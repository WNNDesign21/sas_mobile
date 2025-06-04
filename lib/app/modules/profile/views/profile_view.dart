// d:\kuliah\sas_mobile\lib\app\modules\profile\views\profile_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/profile_controller.dart';
import '../../widget/sidebar_widget.dart';
import '../../widget/profile_widget.dart'; // Asumsi ProfileCard dan SaveButton ada di sini

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: const SidebarWidget(),
      body: Stack(
        children: <Widget>[
          // Background Image
          Positioned(
            child: Container(
              height: screenHeight * 0.8,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/Image3.png',
                  ), // Pastikan asset ini ada
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),

          // Overlay Merah
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height:
                  screenHeight *
                  0.8, // Lebih pendek supaya profile card lebih terlihat
              color: const Color.fromARGB(255, 121, 22, 15).withOpacity(0.7),
            ),
          ),

          // Konten utama
          Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Obx(() {
                  // Bungkus dengan Obx untuk reaktivitas
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  if (controller.errorMessage.value != null) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Error: ${controller.errorMessage.value}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => controller.fetchProfileData(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color.fromARGB(
                                  255,
                                  121,
                                  22,
                                  15,
                                ),
                              ),
                              child: const Text("Coba Lagi"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  // Jika tidak loading dan tidak ada error, tampilkan konten profil
                  // Bungkus SingleChildScrollView dengan RefreshIndicator
                  return RefreshIndicator(
                    color: const Color.fromARGB(
                      255,
                      194,
                      0,
                      30,
                    ), // Warna indikator
                    onRefresh: () async {
                      // Fungsi ini dipanggil saat pengguna menarik ke bawah
                      await controller.fetchProfileData();
                    },
                    child: const SingleChildScrollView(
                      // SingleChildScrollView tetap ada
                      // Tambahkan physics agar bisa di-scroll meskipun konten pendek
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ), // Mengatur jarak biar tidak terlalu ke bawah
                          ProfileCard(), // Menggunakan ProfileCard
                          SizedBox(
                            height: 10,
                          ), // Jarak antar elemen lebih nyaman
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),

          // Tombol "Simpan" Diletakkan di Bagian Bawah
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Center(
              child: Column(children: const [SaveButton()]),
            ), // Menggunakan SaveButton
          ),
        ],
      ),
    );
  }

  // Widget Header
  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 110,
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
      child: SafeArea(
        // Menggunakan SafeArea untuk menghindari status bar
        bottom: false,
        child: Stack(
          children: [
            // Judul Header
            Center(
              // Menggunakan Center untuk menempatkan judul di tengah
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ), // Sedikit padding dari atas SafeArea
                child: Text(
                  'Profile', // Judul "Profile"
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balooBhai2(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Tombol Menu (Hamburger)
            Positioned(
              top: 0, // Posisikan di bagian atas SafeArea
              left: 10, // Sedikit jarak dari kiri
              child: Builder(
                builder:
                    (context) => IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip:
                          MaterialLocalizations.of(
                            context,
                          ).openAppDrawerTooltip,
                    ),
              ),
            ),
            // Logo SAS Putih
            Positioned(
              top: 10, // Sesuaikan posisi vertikal logo
              right: 20, // Jarak dari kanan
              child: Image.asset(
                'assets/images/logosasputih.png', // Pastikan asset ini ada
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
