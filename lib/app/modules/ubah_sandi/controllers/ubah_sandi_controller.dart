import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UbahSandiController extends GetxController {
  //TODO: Implement UbahSandiController

  // Controller untuk input form
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Function untuk validasi dan simpan password
  void changePassword() {
    String currentPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Semua kolom harus diisi',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar('Error', 'Password baru dan konfirmasi password tidak sama',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar('Error', 'Password baru harus lebih dari 6 karakter',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Simulasi update password (bisa disesuaikan dengan API backend)
    Future.delayed(Duration(seconds: 2), () {
      Get.snackbar('Sukses', 'Password berhasil diperbarui',
          backgroundColor: Colors.green, colorText: Colors.white);
    });
  }

  @override
  void onClose() {
    // Membersihkan controller saat tidak digunakan
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
