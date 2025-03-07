import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart'; // Sudah benar

void main() {
  runApp(
    GetMaterialApp(
      title: "Smart Attandance Students",
      initialRoute: AppPages.INITIAL, // Sudah benar
      getPages: AppPages.routes, // Sudah benar
      debugShowCheckedModeBanner: false,
    ),
  );
}
