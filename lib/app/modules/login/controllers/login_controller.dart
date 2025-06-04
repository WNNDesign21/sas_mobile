// lib/app/modules/login/controllers/login_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart'; // Import AuthService dan LoginResult
import '../../widget/loading_login_screen.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final idUserController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  // errorMessage Rxn tidak lagi diperlukan untuk menampilkan error utama
  // final errorMessage = Rxn<String>();

  Future<void> login() async {
    // Variabel untuk menyimpan pesan error jika ada
    String? loginErrorMessage;

    final String idUser = idUserController.text.trim();
    final String password = passwordController.text.trim();

    if (idUser.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Peringatan",
        "ID User (NPM) dan Password harus diisi",
        backgroundColor: Colors.orange[700],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    LoadingLoginScreen.showLoading();

    try {
      // Panggil login dan dapatkan LoginResult
      final LoginResult result = await _authService.login(idUser, password);

      if (result.success) {
        print("Login Controller: Login API Berhasil.");
        // Navigasi hanya jika sukses
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        // Jika gagal, simpan pesan error untuk ditampilkan nanti
        print("Login Controller: Login API Gagal.");
        loginErrorMessage = result.message; // Simpan pesan dari AuthService
      }
    } catch (e) {
      // Tangani error tak terduga di controller
      print("Login Controller: Terjadi error tak terduga: $e");
      loginErrorMessage =
          "Terjadi kesalahan tidak terduga."; // Pesan error generik
    } finally {
      // Selalu jalankan ini: tutup loading
      isLoading.value = false;
      LoadingLoginScreen.hideLoading();
    }

    // ---- Tampilkan Snackbar SETELAH finally ----
    // Jika ada pesan error yang tersimpan, tampilkan snackbar
    if (loginErrorMessage != null) {
      Get.snackbar(
        "Login Gagal", // Judul Snackbar
        loginErrorMessage, // Pesan error spesifik
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4), // Durasi tampil snackbar
      );
    }
  }

  @override
  void onClose() {
    idUserController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
