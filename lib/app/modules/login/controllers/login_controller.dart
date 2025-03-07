import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController npmController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs; // Menggunakan RxBool
  final RxString errorMessage = "".obs; // Menggunakan RxString

  // Simulasi proses login
  Future<void> login() async {
    String npm = npmController.text.trim();
    String password = passwordController.text.trim();

    if (npm.isEmpty || password.isEmpty) {
      errorMessage.value = "NPM dan Password wajib diisi!";
      return;
    }

    // Simulasi loading
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));

    // Simulasi autentikasi sukses
    if (npm == "12345678" && password == "123") {
      errorMessage.value = "";
      isLoading.value = false;

      // 🔥 Navigasi ke dashboard setelah login berhasil
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      errorMessage.value = "NPM atau Password salah!";
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    npmController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
