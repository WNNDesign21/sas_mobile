import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // Untuk Colors di Snackbar
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vpn_connection_detector/vpn_connection_detector.dart'; // Import untuk deteksi VPN
import 'package:geolocator/geolocator.dart'; // Untuk lokasi dan deteksi mock

import '../../../services/auth_service.dart'; // Sesuaikan path jika perlu
import '../../../utils/env_helper.dart'; // Sesuaikan path jika perlu

// KAMPUS
// const double TARGET_LATITUDE = -6.2892088; // Ganti dengan Latitude target Anda
// const double TARGET_LONGITUDE =
//     107.2921542; // Ganti dengan Longitude target Anda
// const double ALLOWED_RADIUS_METERS = 20.0; // Radius yang diizinkan dalam meter

const double TARGET_LATITUDE = -6.2899582; // Ganti dengan Latitude target Anda
const double TARGET_LONGITUDE =
    107.2928704; // Ganti dengan Longitude target Anda
const double ALLOWED_RADIUS_METERS =
    1000.0; // Radius yang diizinkan dalam meter

class ScanqrController extends GetxController {
  final MobileScannerController cameraController = MobileScannerController();
  final RxBool isFlashOn = false.obs;
  final RxBool isFrontCamera = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Meminta izin lokasi saat controller diinisialisasi
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  void toggleFlash() {
    cameraController.toggleTorch();
    isFlashOn.value = !isFlashOn.value;
  }

  void switchCamera() {
    cameraController.switchCamera();
    isFrontCamera.value = !isFrontCamera.value;
  }

  Future<void> processQrCode(String qrDataFromScanner) async {
    if (isLoading.value) {
      print("ℹ️ Proses scan QR sedang berjalan, permintaan diabaikan.");
      return; // Mencegah multiple submissions
    }

    isLoading.value = true;
    errorMessage.value = '';

    bool isVpnActive = false;
    try {
      // Menggunakan metode isVpnActive dari vpn_connection_detector
      isVpnActive =
          await VpnConnectionDetector.isVpnActive(); // Menggunakan nama kelas yang benar
      if (isVpnActive) {
        errorMessage.value =
            "VPN terdeteksi. Harap matikan VPN untuk melanjutkan.";
        Get.snackbar(
          "Keamanan",
          errorMessage.value,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }
    } catch (e) {
      print("Error checking VPN status: $e");
      // Jika pengecekan VPN gagal, kita bisa memilih untuk memblokir atau melanjutkan dengan peringatan.
      // Untuk saat ini, kita log error dan melanjutkan, tapi ini bisa diubah sesuai kebijakan keamanan.
      print(
        "ScanqrController: Gagal memverifikasi status VPN. Melanjutkan dengan hati-hati.",
      );
    }

    // 3. Validasi Lokasi dan Radius
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      errorMessage.value =
          "Izin lokasi ditolak. Tidak dapat memvalidasi lokasi Anda.";
      Get.snackbar(
        "Error Lokasi",
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
      await _requestLocationPermission(); // Coba minta izin lagi
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 20), // Tambahkan time limit
      );

      // Deteksi Fake GPS (Mock Location) menggunakan Geolocator
      if (position.isMocked) {
        errorMessage.value =
            "Fake GPS terdeteksi. Harap matikan aplikasi Fake GPS.";
        Get.snackbar(
          "Keamanan",
          errorMessage.value,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }
      print("✅ Lokasi tidak terdeteksi sebagai mock/fake.");

      double distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        TARGET_LATITUDE,
        TARGET_LONGITUDE,
      );

      if (distanceInMeters > ALLOWED_RADIUS_METERS) {
        errorMessage.value =
            "Anda berada di luar radius yang diizinkan untuk scan QR (${distanceInMeters.toStringAsFixed(0)}m).";
        Get.snackbar(
          "Lokasi Tidak Valid",
          errorMessage.value,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }
      print(
        "✅ Lokasi valid. Jarak: ${distanceInMeters.toStringAsFixed(2)} meter.",
      );
    } on TimeoutException catch (_) {
      errorMessage.value =
          "Gagal mendapatkan lokasi (timeout). Pastikan GPS Anda aktif dan sinyal baik.";
      Get.snackbar(
        "Error Lokasi",
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
      return;
    } catch (e) {
      errorMessage.value = "Gagal mendapatkan lokasi: ${e.toString()}";
      Get.snackbar(
        "Error Lokasi",
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
      return;
    }

    try {
      final authService = Get.find<AuthService>();
      // Asumsi user.value tidak null dan idUser ada dan bertipe String atau bisa diubah ke String
      // Mengambil id_user dari AuthService yang sudah disimpan saat login
      final String? idUser = authService.currentUserId.value;

      if (idUser == null || idUser.isEmpty) {
        errorMessage.value = "User tidak ditemukan. Silakan login kembali.";
        Get.snackbar(
          "Error Autentikasi",
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }

      final baseUrl = EnvHelper.apiBaseUrl;
      if (baseUrl.isEmpty) {
        errorMessage.value = "API Base URL tidak dikonfigurasi.";
        Get.snackbar(
          "Error Konfigurasi",
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }

      final url = Uri.parse('$baseUrl/scanqr'); // Corrected Endpoint API
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      };
      final body = {'id_user': idUser, 'qr_data': qrDataFromScanner};

      if (kDebugMode) {
        print('--- API Scan QR Request ---');
        print('URL: $url');
        print('Method: POST');
        print('Headers: $headers');
        print('Body: $body');
        print('---------------------------');
      }

      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 30)); // Timeout 30 detik

      if (kDebugMode) {
        print('--- API Scan QR Response ---');
        print('Status Code: ${response.statusCode}');
        print('Body: ${response.body}');
        print('----------------------------');
      }

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Asumsi API mengembalikan JSON dengan field 'success': true atau 'status': 'success' dan 'message'
        // Sesuaikan dengan respons aktual API Anda
        if (responseBody['success'] == true || // Check for 'success' key
            (responseBody['status'] != null &&
                responseBody['status'] ==
                    true) // Check for 'status' key as boolean true
            ) {
          Get.snackbar(
            "Sukses",
            responseBody['message'] ?? "QR Code berhasil diproses.",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // ✅ Tambahkan ini untuk redirect dan refresh data
          Get.offAllNamed('/dashboard', arguments: {'refresh': true});
          // Anda mungkin ingin melakukan navigasi atau aksi lain di sini
          // Get.back(); // Contoh: kembali ke halaman sebelumnya setelah sukses
        } else {
          errorMessage.value =
              responseBody['message'] ?? "Gagal memproses QR Code dari server.";
          Get.snackbar(
            "Gagal",
            errorMessage.value,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
        }
      } else {
        errorMessage.value =
            responseBody['message'] ??
            "Error: ${response.statusCode}. Gagal menghubungi server.";
        Get.snackbar(
          "Error Server",
          errorMessage.value,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on TimeoutException catch (_) {
      errorMessage.value =
          "Waktu koneksi habis. Periksa koneksi internet Anda.";
      Get.snackbar(
        "Error Koneksi",
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessage.value = "Terjadi kesalahan: ${e.toString()}";
      Get.snackbar(
        "Error Tidak Diketahui",
        errorMessage.value,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      if (kDebugMode) {
        print("❌ Error saat memproses QR Code: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Pastikan controller di-dispose untuk menghindari memory leak
    cameraController.dispose();
    super.onClose();
  }
}
