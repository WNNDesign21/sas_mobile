import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final namaController = TextEditingController();
  final npmController = TextEditingController();
  final fictController = TextEditingController();
  final emailController = TextEditingController();
  final ibuController = TextEditingController();
  final agamaController = TextEditingController();
  final alamatController = TextEditingController();

  @override
  void onClose() {
    namaController.dispose();
    npmController.dispose();
    fictController.dispose();
    emailController.dispose();
    ibuController.dispose();
    agamaController.dispose();
    alamatController.dispose();
    super.onClose();
  }
}
