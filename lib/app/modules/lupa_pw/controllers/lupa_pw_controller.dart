import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LupaPwController extends GetxController {
  //TODO: Implement LupaPwController

  // final count = 0.obs;

  // void increment() => count.value++;

  TextEditingController MasukanEmailController = TextEditingController();

  var isLoading = false.obs;

  // Fungsi untuk mengirim OTP
  Future<void> sendOTP() async {
    // Implementasi logic kirim OTP
    isLoading.value = true;
    // Simulasi delay
    await Future.delayed(const Duration(seconds: 3));
    isLoading.value = false;
  }
}
