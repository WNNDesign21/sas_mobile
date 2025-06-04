// lib/app/services/auth_service.dart

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../utils/env_helper.dart';

// Kelas LoginResult tetap sama (hanya success dan message)
class LoginResult {
  final bool success;
  final String? message;
  LoginResult(this.success, {this.message});
}

class AuthService extends GetxService {
  final RxBool isLoggedIn = false.obs;
  // --- TAMBAHKAN STATE UNTUK DATA USER ---
  final RxnString currentUserName = RxnString(null);
  final RxnString currentUserProfilePath = RxnString(
    null,
  ); // Simpan path relatif
  final RxnString currentUserId = RxnString(null); // Menyimpan ID user
  // --- AKHIR PENAMBAHAN STATE ---

  final Duration _requestTimeout = const Duration(seconds: 15);

  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = false;
    // Reset data user saat init (opsional, tergantung logika sesi)
    currentUserName.value = null;
    currentUserProfilePath.value = null;
    currentUserId.value = null;
    print("AuthService Initialized (Using HTTP, No Token Handling)");
  }

  Future<LoginResult> login(String username, String password) async {
    final baseUrl = EnvHelper.apiBaseUrl;
    String errorMessage = "Terjadi kesalahan tidak terduga.";

    if (baseUrl.isEmpty) {
      errorMessage = "❌ Error: API Base URL tidak dikonfigurasi!";
      print(errorMessage);
      isLoggedIn.value = false;
      return LoginResult(false, message: errorMessage);
    }

    final url = Uri.parse('$baseUrl/login');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    final body = jsonEncode(<String, String>{
      'id_user': username,
      'password': password,
    });

    if (kDebugMode) {
      print('--- HTTP Request ---');
      print('URL: $url');
      print('Method: POST');
      print('Headers: $headers');
      print('Body: $body');
      print('--------------------');
    }

    try {
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(_requestTimeout);

      if (kDebugMode) {
        print('--- HTTP Response ---');
        print('Status Code: ${response.statusCode}');
        print('Headers: ${response.headers}');
        print('Body: ${response.body}');
        print('---------------------');
      }

      if (response.statusCode == 200) {
        // --- MODIFIKASI SAAT LOGIN SUKSES ---
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        if (responseData['status'] == true && responseData['data'] != null) {
          final userData = responseData['data'] as Map<String, dynamic>;

          print("✅ Login validation successful (Status Code: 200)");
          isLoggedIn.value = true;

          // Simpan data user ke state AuthService
          currentUserName.value = userData['nama'];
          currentUserProfilePath.value =
              userData['foto_profil']; // Simpan path relatif
          currentUserId.value =
              username; // Simpan ID user yang digunakan untuk login
          print(
            "   User Data Stored: Name=${currentUserName.value}, Path=${currentUserProfilePath.value}",
          );

          return LoginResult(true); // Kembalikan sukses
        } else {
          // Handle jika status 200 tapi API bilang gagal
          errorMessage =
              responseData['message'] ?? "Login gagal (respon tidak valid).";
          print("❌ Login Gagal (API Status False): $errorMessage");
          isLoggedIn.value = false;
          // Reset data user jika login gagal
          currentUserName.value = null;
          currentUserId.value = null;
          currentUserProfilePath.value = null;
          return LoginResult(false, message: errorMessage);
        }
        // --- AKHIR MODIFIKASI ---
      } else {
        // Tangani error status code (401, 404, dll.)
        print("❌ Login Gagal: Status code ${response.statusCode}");
        print("Response body: ${response.body}");
        try {
          final errorData = jsonDecode(response.body) as Map<String, dynamic>;
          errorMessage =
              errorData['message'] ??
              _getDefaultErrorMessage(response.statusCode);
        } catch (_) {
          errorMessage = _getDefaultErrorMessage(response.statusCode);
        }
        isLoggedIn.value = false;
        // Reset data user jika login gagal
        currentUserName.value = null;
        currentUserId.value = null;
        currentUserProfilePath.value = null;
        return LoginResult(false, message: errorMessage);
      }
    } on TimeoutException catch (_) {
      print("❌ Error: Request timeout saat login.");
      errorMessage = "Waktu koneksi habis. Periksa internet Anda.";
      isLoggedIn.value = false;
      currentUserName.value = null;
      currentUserId.value = null;
      currentUserProfilePath.value = null;
      return LoginResult(false, message: errorMessage);
    } on http.ClientException catch (e) {
      print("❌ Error ClientException saat login: $e");
      errorMessage = "Tidak dapat terhubung ke server.";
      isLoggedIn.value = false;
      currentUserName.value = null;
      currentUserId.value = null;
      currentUserProfilePath.value = null;
      return LoginResult(false, message: errorMessage);
    } catch (e) {
      print("❌ Error tidak terduga saat login: $e");
      isLoggedIn.value = false;
      currentUserName.value = null;
      currentUserId.value = null;
      currentUserProfilePath.value = null;
      return LoginResult(false, message: errorMessage);
    }
  }

  // Helper untuk pesan error default
  String _getDefaultErrorMessage(int? statusCode) {
    if (statusCode == 401) {
      return "Username atau password salah.";
    } else if (statusCode == 404) {
      return "User tidak ditemukan.";
    } else {
      return "Terjadi kesalahan server (${statusCode ?? 'N/A'}).";
    }
  }

  Future<void> logout() async {
    isLoggedIn.value = false;
    // Reset data user saat logout
    currentUserName.value = null;
    currentUserId.value = null;
    currentUserProfilePath.value = null;
    print("Pengguna telah logout (status & data lokal direset).");
    // Redirect bisa dilakukan di controller yang memanggil logout jika perlu
    // Get.offAllNamed(Routes.LOGIN);
  }
}
