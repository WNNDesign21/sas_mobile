import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> subjects = [
    {
      "name": "Pemrograman Web",
      "data": [90.0, 85.0, 80.0, 75.0, 60.0, 65.0],
      "color": Colors.purple,
    },
    {
      "name": "Pemrograman Mobile",
      "data": [70.0, 75.0, 85.0, 95.0, 80.0, 75.0],
      "color": Colors.blue,
    },
    {
      "name": "Data Science",
      "data": [60.0, 65.0, 70.0, 75.0, 80.0, 85.0],
      "color": Colors.green,
    }
  ];

  // Durasi Animasi
  final Duration animationDuration = const Duration(milliseconds: 500);

  // Controller untuk Animasi Grafik
  late AnimationController chartAnimationController;
  late Animation<double> chartAnimation;

  // Status Animasi Student Photo
  final RxBool showStudentPhoto = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Controller untuk Animasi Grafik
    chartAnimationController = AnimationController(
      duration: animationDuration,
      vsync: this,
    );
    chartAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: chartAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    // Jalankan animasi grafik
    chartAnimationController.forward();

    // Mulai animasi student photo setelah 500ms
    Future.delayed(const Duration(milliseconds: 1300), () {
      showStudentPhoto.value = true;
    });
  }

  @override
  void onClose() {
    chartAnimationController.dispose();
    super.onClose();
  }
}
