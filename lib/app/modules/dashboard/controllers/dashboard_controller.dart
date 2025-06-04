// lib/app/modules/dashboard/controllers/dashboard_controller.dart

import 'dart:convert'; // Diperlukan untuk jsonEncode/jsonDecode
import 'dart:async'; // Diperlukan untuk TimeoutException
import 'package:flutter/material.dart'; // Diperlukan untuk AnimationController, vsync, Color
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Import package http

// Import helper dan service yang relevan
import '../../../services/auth_service.dart';
import '../../../utils/env_helper.dart';
// import '../../../routes/app_pages.dart'; // Tidak perlu lagi jika tidak ada redirect dari sini

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Mixin untuk vsync animasi

  // --- State untuk Data User (Membaca dari AuthService) ---
  final AuthService _authService =
      Get.find<AuthService>(); // Dapatkan instance AuthService

  // Gunakan Rx getter untuk membaca state dari AuthService secara reaktif
  // Memberikan nilai default jika data di AuthService null atau kosong
  RxString get userName =>
      RxString(_authService.currentUserName.value ?? 'User');

  // Getter untuk URL gambar lengkap, memanggil helper _buildFullImageUrl
  RxString get profileImageUrl =>
      RxString(_buildFullImageUrl(_authService.currentUserProfilePath.value));

  // --- State untuk Data Grafik Absensi (Dinamis) ---
  final RxList<Map<String, dynamic>> attendanceChartData =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoadingAttendance = true.obs;
  final RxnString attendanceError = RxnString(null);
  final Duration _requestTimeout = const Duration(
    seconds: 15,
  ); // Timeout untuk request API

  // Daftar warna untuk chart, bisa Anda sesuaikan
  final List<Color> _chartColors = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.teal,
    Colors.pink,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lime,
    Colors.brown,
  ];

  // --- Animasi Grafik (Tetap Ada) ---
  final Duration animationDuration = const Duration(milliseconds: 500);
  late AnimationController chartAnimationController;
  late Animation<double> chartAnimation;

  @override
  void onInit() {
    super.onInit();
    // --- Setup Animasi Grafik (Tetap Ada) ---
    chartAnimationController = AnimationController(
      duration: animationDuration,
      vsync: this, // 'this' dari GetSingleTickerProviderStateMixin
    );
    chartAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: chartAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    chartAnimationController.forward(); // Jalankan animasi grafik

    // Panggil fungsi untuk mengambil data absensi
    _fetchAttendanceData();

    // Log data awal yang dibaca dari AuthService
    print("DashboardController Initialized. Reading data from AuthService.");
    print("   Initial Name: ${userName.value}"); // Akses via getter .value
    print(
      "   Initial Image URL: ${profileImageUrl.value}",
    ); // Akses via getter .value

    // Cek jika user tidak login saat masuk dashboard (sebagai pengaman tambahan)
    if (!_authService.isLoggedIn.value) {
      print(
        "WARNING: User is not logged in upon entering Dashboard!",
        // isError: true, // print tidak punya parameter isError
      );
      // Pertimbangkan redirect ke login jika ini terjadi
      // Future.delayed(Duration.zero, () => Get.offAllNamed(Routes.LOGIN));
    }
  }

  Future<void> _fetchAttendanceData() async {
    try {
      isLoadingAttendance.value = true;
      attendanceError.value = null;

      final userId = _authService.currentUserId.value;

      if (userId == null || userId.isEmpty) {
        print('DashboardController: User ID tidak tersedia.');
        throw Exception('User ID tidak tersedia untuk mengambil data absensi.');
      }

      final baseUrl = EnvHelper.apiBaseUrl;
      if (baseUrl.isEmpty) {
        print(
          'DashboardController: API Base URL tidak dikonfigurasi!',
          // isError: true,
        );
        throw Exception('API Base URL tidak dikonfigurasi.');
      }

      // Membuat URI dengan query parameters
      final uri = Uri.parse(
        '$baseUrl/absensi',
      ).replace(queryParameters: {'id_user': userId});

      print('DashboardController: Fetching attendance from: $uri');

      final response = await http
          .get(uri, headers: {'Accept': 'application/json'})
          .timeout(_requestTimeout);

      print('DashboardController: Response status: ${response.statusCode}');
      // print('DashboardController: Response body: ${response.body}'); // Uncomment untuk debug detail response

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        if (responseData['status'] == true &&
            responseData['data'] != null &&
            responseData['data'] is List) {
          final List<dynamic> rawDataList = responseData['data'];
          if (rawDataList.isEmpty) {
            print('DashboardController: Data absensi kosong dari API.');
            attendanceChartData.clear();
          } else {
            print(
              'DashboardController: Raw data count from API: ${rawDataList.length}',
            ); // Log jumlah data mentah
            attendanceChartData.assignAll(
              rawDataList.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> item = entry.value as Map<String, dynamic>;
                // Log setiap item yang diproses
                print(
                  'DashboardController: Processing item $index: ${item['nama_mk']} - ${item['persentase_kehadiran']}%',
                );
                return {
                  "name": item['nama_mk'] as String,
                  "data": [(item['persentase_kehadiran'] as num).toDouble()],
                  "color": _chartColors[index % _chartColors.length],
                };
              }).toList(),
            );
          }
          print(
            "DashboardController: Attendance data loaded: ${attendanceChartData.length} items.",
          );
        } else {
          final message =
              responseData['message']?.toString() ??
              'Format respons tidak valid atau status false.';
          print(
            'DashboardController: Gagal memuat data absensi - $message',
            // isError: true,
          );
          throw Exception(message);
        }
      } else {
        String errorMessage;
        try {
          final errorData = jsonDecode(response.body) as Map<String, dynamic>;
          errorMessage =
              errorData['message'] ??
              'Gagal memuat data absensi: Status ${response.statusCode}';
        } catch (_) {
          errorMessage =
              'Gagal memuat data absensi: Status ${response.statusCode}';
        }
        print('DashboardController: $errorMessage');
        throw Exception(errorMessage);
      }
    } on TimeoutException catch (_) {
      print(
        'DashboardController: Request timeout saat mengambil data absensi.',
        // isError: true,
      );
      attendanceError.value = 'Waktu koneksi habis. Periksa internet Anda.';
      attendanceChartData.clear();
    } on http.ClientException catch (e) {
      print(
        'DashboardController: ClientException saat mengambil data absensi: $e',
        // isError: true,
      );
      attendanceError.value = 'Tidak dapat terhubung ke server.';
      attendanceChartData.clear();
    } catch (e) {
      print(
        'DashboardController: Error fetching attendance data: $e',
        // isError: true,
      );
      attendanceError.value = 'Terjadi kesalahan: ${e.toString()}';
      attendanceChartData.clear();
    } finally {
      isLoadingAttendance.value = false;
    }
  }

  /// Helper untuk membangun URL gambar lengkap dari path relatif
  String _buildFullImageUrl(String? relativePath) {
    // Jika path null atau kosong, kembalikan string kosong
    if (relativePath == null || relativePath.isEmpty) {
      // print("_buildFullImageUrl: Relative path is null or empty."); // Opsional
      return '';
    }

    // Ambil base URL API (misal: http://192.168.137.1/sas/api)
    final apiBaseUrl = EnvHelper.apiBaseUrl;
    if (apiBaseUrl.isEmpty) {
      // print("_buildFullImageUrl: API Base URL is empty."); // Opsional
      return ''; // Kembalikan kosong jika base URL API tidak ada
    }

    // Buat base URL server (hapus '/api' atau '/api/' di akhir)
    String serverBaseUrl = apiBaseUrl;
    if (serverBaseUrl.endsWith('/api/')) {
      serverBaseUrl = serverBaseUrl.substring(
        0,
        serverBaseUrl.length - '/api/'.length,
      );
    } else if (serverBaseUrl.endsWith('/api')) {
      serverBaseUrl = serverBaseUrl.substring(
        0,
        serverBaseUrl.length - '/api'.length,
      );
    }

    // Gabungkan base URL server dengan path relatif gambar
    // Pastikan tidak ada double slash (/) jika relativePath dimulai dengan /
    final finalUrl =
        '$serverBaseUrl/${relativePath.startsWith('/') ? relativePath.substring(1) : relativePath}';
    // print("_buildFullImageUrl: Constructed URL: $finalUrl"); // Opsional
    return finalUrl;
  }

  @override
  void onClose() {
    // Pastikan controller animasi di-dispose
    chartAnimationController.dispose();
    print("DashboardController closed and chart animation disposed.");
    super.onClose();
  }

  @override
  void refreshData() {
    _fetchAttendanceData(); // atau method lain yang kamu ingin update
  }
}
