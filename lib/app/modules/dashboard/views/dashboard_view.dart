import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/dashboard_controller.dart';
import '../../../routes/app_pages.dart';
import '../../widget/animated_widgets.dart';
import '../../widget/sidebar_widget.dart'; // Import widget sidebar

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarWidget(), // Gunakan widget sidebar
      body: Stack(
        children: [
          Column(
            // Gunakan Expanded agar Column mengisi ruang yang tersisa
            // dan SingleChildScrollView agar bisa di-scroll jika konten melebihi layar
            children: <Widget>[
              _buildHeader(context),
              _buildStudentPhoto(), // Ini sudah Expanded di dalamnya
              // Menampilkan satu chart absensi
              _buildAttendanceChart(), // Mengganti _buildCarouselSlider
              _buildFooter(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 110, // Ketinggian header
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
        // Gunakan SafeArea agar konten tidak tertutup notch/statusbar
        bottom: false, // Tidak perlu SafeArea di bagian bawah Container ini
        child: Stack(
          children: [
            // Center Column untuk Welcome dan Nama
            Center(
              child: Padding(
                // Beri sedikit padding agar tidak terlalu mepet ke atas
                padding: const EdgeInsets.only(top: 5.0),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Pusatkan secara vertikal
                  children: [
                    Text(
                      'Welcome',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.balooBhai2(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // --- PERUBAHAN DI SINI ---
                    // Bungkus Text nama dengan Obx
                    Obx(
                      () => Text(
                        // Langsung tampilkan nama dari controller.userName
                        // Getter di controller sudah memberikan nilai default 'User'
                        controller.userName.value,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.balooBhai2(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        overflow: TextOverflow.ellipsis, // Handle nama panjang
                        maxLines: 1,
                      ),
                    ),
                    // --- AKHIR PERUBAHAN ---
                  ],
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
                        // Buka drawer (SidebarWidget)
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
                'assets/images/logosasputih.png', // Pastikan path asset benar
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan foto (tidak perlu diubah)
  Widget _buildStudentPhoto() {
    // AnimatedStudentPhoto sudah menggunakan Expanded
    return const AnimatedStudentPhoto();
  }

  // Widget untuk menampilkan satu chart absensi
  Widget _buildAttendanceChart() {
    // Mungkin perlu dibungkus Flexible atau SizedBox jika ada masalah layout vertikal
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 15, left: 5, right: 5),
      child: Obx(() {
        if (controller.isLoadingAttendance.value) {
          return const SizedBox(
            height: 220, // Sesuaikan tinggi jika perlu
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (controller.attendanceError.value != null) {
          return SizedBox(
            height: 220, // Sesuaikan tinggi jika perlu
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${controller.attendanceError.value}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        if (controller.attendanceChartData.isEmpty) {
          return const SizedBox(
            height: 220, // Sesuaikan tinggi jika perlu
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Tidak ada data absensi untuk ditampilkan.'),
              ),
            ),
          );
        }
        // If data is available, show the single chart container
        return Container(
          height: 220, // Sesuaikan tinggi jika perlu
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "Grafik Kehadiran", // Judul Umum untuk Chart
                style: GoogleFonts.balooBhai2(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // AnimatedChart sekarang menerima List<Map<String, dynamic>>
              Expanded(
                child: AnimatedChart(subject: controller.attendanceChartData),
              ),
              // Anda bisa menambahkan legenda kustom di sini jika diperlukan
              // dan jika AnimatedChart tidak menanganinya secara internal untuk multiple series.
            ],
          ),
        );
      }),
    );
  }

  // Widget untuk Footer (tidak perlu diubah)
  Widget _buildFooter() {
    // Gunakan Align atau Positioned jika ingin menempel di bawah layar
    // Jika bagian dari Column utama, ia akan berada di bawah Carousel
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Gambar background navbar
          SizedBox(
            // Gunakan SizedBox agar bisa atur tinggi
            height: 75,
            width: double.infinity, // Lebar penuh
            child: Image.asset(
              "assets/images/navbar.png", // Pastikan path asset benar
              fit: BoxFit.cover, // Cover area SizedBox
            ),
          ),
          // Tombol QR Scanner di tengah
          Positioned(
            bottom: 15, // Jarak dari bawah
            child: GestureDetector(
              onTap: () async {
                // Navigasi ke halaman QR Scanner
                var result = await Get.toNamed(Routes.QR);
                if (result != null) {
                  // ignore: avoid_print
                  print("Data QR : $result");
                  Get.snackbar("QR Code Scanned!", "Data: $result");
                } else {
                  // ignore: avoid_print
                  print("No QR data scanned or user cancelled");
                }
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white, // Background tombol putih
                radius: 30, // Ukuran tombol
                child: Icon(
                  Icons.qr_code_scanner,
                  color: Colors.black, // Warna ikon hitam
                  size: 40, // Ukuran ikon
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
