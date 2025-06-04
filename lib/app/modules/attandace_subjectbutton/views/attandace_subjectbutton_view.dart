import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_pages.dart'; // Pastikan import Routes sudah benar
import '../../widget/sidebar_widget.dart'; // Import SidebarWidget
import '../controllers/attandace_subjectbutton_controller.dart';

class AttandaceSubjectbuttonView
    extends GetView<AttandaceSubjectbuttonController> {
  const AttandaceSubjectbuttonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarWidget(),
      body: Stack(
        children: <Widget>[
          // 🔹 Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset('assets/images/bgfix.png', fit: BoxFit.cover),
            ),
          ),
          _buildHeader(context, controller),

          // 🔹 Content
          Padding(
            padding: const EdgeInsets.only(top: 150), // Jarak dari atas
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Pindahkan konten ke atas
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Pusatkan secara horizontal
              children: [
                // Tampilkan judul mata kuliah dari controller
                Obx(
                  () => Text(
                    controller.subjectTitle.value.isNotEmpty
                        ? controller.subjectTitle.value
                        : 'Memuat...', // Tampilkan "Memuat..." jika judul belum ada
                    style: GoogleFonts.balooBhai2(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Tombol-tombol lainnya
                _buildButton(
                  text: "Attendance Check",
                  color: const Color.fromRGBO(194, 1, 30, 1),
                  onPressed: () {
                    Get.toNamed(
                      '${Routes.ATTANDANCE_CHECK}?idMk=${Uri.encodeComponent(controller.subjectIdMk.value)}&subjectTitle=${Uri.encodeComponent(controller.subjectTitle.value)}',
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildEarlyAdmissionButton(
                  text: "Early Admission Submission",
                  subText: "(Employee Night Class Only)",
                  color: const Color.fromRGBO(0, 116, 40, 1),
                  onPressed: () {
                    Get.toNamed(Routes.ATTANDANCE_EARLY);
                  },
                ),
                const SizedBox(height: 20),
                _buildButton(
                  text: "Permit Letter",
                  color: const Color.fromRGBO(1, 118, 168, 1),
                  onPressed: () {
                    Get.toNamed(Routes.ATTANDANCE_PERMIT);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Header
  Widget _buildHeader(
    BuildContext context,
    AttandaceSubjectbuttonController controller,
  ) {
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
        bottom: false,
        child: Stack(
          children: [
            // Tombol Back
            Positioned(
              top: 0, // Sesuaikan dengan SafeArea
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Get.back(),
                tooltip: 'Kembali',
              ),
            ),
            // Judul Halaman (nama mata kuliah dinamis dari controller)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 50,
                  right: 50,
                ), // Padding agar tidak tertutup tombol back/logo
                child: Obx(
                  () => Text(
                    controller.subjectTitle.value.isNotEmpty
                        ? controller
                            .subjectTitle
                            .value // Menggunakan nilai dari controller
                        : 'Detail Absensi', // Judul dinamis
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.balooBhai2(
                      color: Colors.white,
                      fontSize: 22, // Ukuran font disesuaikan
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Tombol Menu (opsional, jika tetap ingin ada sidebar di halaman ini)
            /* Positioned(
              top: 0, // Sesuaikan dengan SafeArea
              left: 10, // Atau di kanan jika tombol back di kiri
              child: Builder(
                builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white, size: 39),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
            ),
          ),
          */
            // Logo (opsional)
            Positioned(
              top: 10, // Sesuaikan dengan SafeArea
              right: 20,
              child: Image.asset(
                'assets/images/logosasputih.png',
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build button function
  Widget _buildButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(37),
            ),
            // ignore: deprecated_member_use
            shadowColor: Colors.black.withOpacity(0.2),
            elevation: 7,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: GoogleFonts.baloo2(
              // Use Baloo2
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Build Early Admission Button with Subtext
  Widget _buildEarlyAdmissionButton({
    required String text,
    required String subText,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(37),
            ),
            // ignore: deprecated_member_use
            shadowColor: Colors.black.withOpacity(0.2),
            elevation: 7,
          ),
          onPressed: onPressed,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: GoogleFonts.baloo2(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subText,
                style: GoogleFonts.baloo2(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
