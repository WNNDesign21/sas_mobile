import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _themeMode = ThemeMode.system.obs; // Default: Ikuti tema sistem

  ThemeMode get themeMode => _themeMode.value;

  void toggleTheme(bool isOn) {
    _themeMode.value = isOn ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(_themeMode.value);
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    Get.changeThemeMode(_themeMode.value);
  }

}
