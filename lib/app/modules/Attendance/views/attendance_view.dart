import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widget/sidebar_widget.dart'; // Import SidebarWidget
import '../controllers/attendance_controller.dart';
import '../../../routes/app_pages.dart'; // Import Routes

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarWidget(), // Menggunakan Sidebar dari widget
      body: Stack(
        children: <Widget>[
          // 🔹 Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset('assets/images/bgfix.png', fit: BoxFit.cover),
            ),
          ),

          // 🔹 Header
          _buildHeader(context),

          // 🔹 Konten
          Padding(
            padding: const EdgeInsets.only(
              top: 150,
            ), // Sesuaikan padding jika header berubah
            child: Column(
              children: [
                // 🔹 Judul "Mata Kuliah"
                Text(
                  'Mata Kuliah',
                  style: GoogleFonts.balooBhai2(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Daftar Mata Kuliah
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.errorMessage.value != null &&
                        controller.subjectsData.isEmpty) {
                      // Menggunakan subjectsData
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Error: ${controller.errorMessage.value}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.redAccent),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () => controller.fetchSubjects(),
                                child: const Text("Coba Lagi"),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if (controller.subjectsData.isEmpty) {
                      // Menggunakan subjectsData
                      return const Center(
                        child: Text("Tidak ada mata kuliah yang tersedia."),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount:
                          controller
                              .subjectsData
                              .length, // Menggunakan subjectsData
                      itemBuilder: (context, index) {
                        final subjectItem =
                            controller
                                .subjectsData[index]; // Menggunakan subjectsData
                        return _buildSubjectButton(subjectItem);
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Header
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
        // Menggunakan SafeArea
        bottom: false,
        child: Stack(
          children: [
            Center(
              // Judul di tengah
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Attendance',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balooBhai2(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0, // Sesuaikan dengan SafeArea
              left: 10,
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

  // 🔹 Widget untuk Tombol Mata Kuliah
  Widget _buildSubjectButton(MataKuliahAbsensiItem subject) {
    // Menerima MataKuliahAbsensiItem
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            shadowColor: Colors.black.withOpacity(0.2),
            elevation: 7,
          ),
          onPressed: () {
            // Navigasi ke halaman detail dengan idMk dan namaMk
            Get.toNamed(
              '${Routes.ATTANDACE_SUBJECTBUTTON}?idMk=${Uri.encodeComponent(subject.idMk)}&subjectTitle=${Uri.encodeComponent(subject.namaMk)}',
            );
          },
          child: Text(
            subject.namaMk, // Menampilkan namaMk dari objek
            style: GoogleFonts.balooBhai2(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}
