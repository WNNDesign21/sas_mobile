import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Attendance/controllers/attendance_controller.dart'; // Import AttendanceController
// Pastikan PertemuanAbsensiItem sudah didefinisikan di AttendanceController atau diimpor dari model jika ada

class AttandanceCheckController extends GetxController {
  // State untuk menyimpan judul mata kuliah dan ID MK
  final RxString subjectTitle = ''.obs;
  final RxString subjectIdMk = ''.obs;

  // State untuk menyimpan data absensi pertemuan untuk mata kuliah ini
  final RxList<PertemuanAbsensiItem> attendanceRecords =
      <PertemuanAbsensiItem>[].obs;

  // State untuk UI (opsional, jika ada loading/error spesifik di halaman ini)
  final RxBool isLoading = false.obs;
  final RxnString errorMessage = RxnString(null);

  // Akses ke AttendanceController untuk mendapatkan data yang sudah di-fetch
  final AttendanceController _attendanceController =
      Get.find<AttendanceController>();

  // State untuk kalender UI yang dikelola oleh controller
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime> selectedDay = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    // Ambil parameter dari GetX navigation
    final parameters = Get.parameters;
    subjectTitle.value = parameters['subjectTitle'] ?? 'Detail Absensi';
    subjectIdMk.value = parameters['idMk'] ?? '';

    if (subjectIdMk.value.isNotEmpty) {
      loadAttendanceDataForSubject();
    } else {
      errorMessage.value = "ID Mata Kuliah tidak ditemukan.";
    }
  }

  void loadAttendanceDataForSubject() {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final foundSubject = _attendanceController.subjectsData.firstWhereOrNull(
        (mk) => mk.idMk == subjectIdMk.value,
      );

      if (foundSubject != null) {
        attendanceRecords.value = foundSubject.absensiPertemuan;
        // Jika ada data, set focusedDay ke tanggal absensi pertama jika memungkinkan
        if (attendanceRecords.isNotEmpty) {
          try {
            final firstRecordDate = DateTime.parse(
              attendanceRecords.first.tanggal,
            );
            focusedDay.value = firstRecordDate;
            selectedDay.value = firstRecordDate;
          } catch (e) {
            // Gagal parse tanggal pertama, biarkan focusedDay default
            print("Error parsing first attendance date: $e");
          }
        }
      } else {
        errorMessage.value =
            "Data absensi untuk mata kuliah ini tidak ditemukan.";
      }
    } catch (e) {
      errorMessage.value = "Gagal memuat data absensi: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'HADIR':
        return Colors.green;
      case 'TIDAK HADIR':
        return Colors.red;
      case 'IZIN': // Asumsi ada status 'IZIN' dari API
        return Colors.cyan;
      default:
        return Colors.grey; // Warna default jika status tidak dikenali
    }
  }

  void onDaySelected(DateTime newSelectedDay, DateTime newFocusedDay) {
    selectedDay.value = newSelectedDay;
    focusedDay.value = newFocusedDay;
  }

  void onPageChanged(DateTime newFocusedDay) {
    focusedDay.value = newFocusedDay;
  }
}
