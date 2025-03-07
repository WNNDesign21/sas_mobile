import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../widget/loading_login_screen.dart';

class LoginController extends GetxController {
  final npmController = TextEditingController();
  final passwordController = TextEditingController();
  final errorMessage = Rxn<String>(); // Gunakan Rxn untuk String nullable
  final isLoading = false.obs;

  Future<void> login() async {
    // Reset error message
    errorMessage.value = null;

    // Validasi input
    if (npmController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      // Tampilkan alert jika NPM atau password kosong
      Get.snackbar(
        "Peringatan",
        "NPM dan Password harus diisi",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return; // Hentikan proses login
    }

    // Tampilkan Loading
    LoadingLoginScreen.showLoading(); // Panggil tanpa await
    isLoading.value = true; // Set isLoading menjadi true saat mulai login

    // Simulasi request login (Ganti dengan logika login yang sebenarnya)
    try {
      // delay 1 detik
      await Future.delayed(const Duration(seconds: 2));

      // contoh login berhasil
      if (npmController.text == '123' && passwordController.text == '123') {
        // Navigasi ke Dashboard jika berhasil
        Get.offAllNamed(Routes.DASHBOARD);
        print("login berhasil");
      } else {
        // Jika login gagal, set error message
        errorMessage.value = "NPM atau Password Salah";
        print("login gagal");
      }
    } catch (e) {
      // Tangani error jika ada
      errorMessage.value = "Terjadi kesalahan saat login.";
      print("Terjadi kesalahan saat login");
    } finally {
      isLoading.value = false; // Set isLoading menjadi false setelah selesai
      LoadingLoginScreen
          .hideLoading(); // Sembunyikan Loading Setelah proses selesai
    }
  }

  @override
  void onClose() {
    npmController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
