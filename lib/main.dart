import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth_service.dart'; // Import AuthService

// Ubah main menjadi async dan return Future<void>
Future<void> main() async {
  // Pastikan binding Flutter siap sebelum operasi async di main
  WidgetsFlutterBinding.ensureInitialized();

  // Muat variabel dari file .env
  try {
    await dotenv.load(fileName: ".env");
    print("✅ File .env berhasil dimuat.");
    // Opsional: Anda bisa log base URL di sini untuk memastikan sudah terbaca
    // print("API Base URL: ${dotenv.env['API_BASE_URL']}");
  } catch (e) {
    // Tangani error jika file .env tidak ditemukan atau gagal dimuat
    print("❌ Error saat memuat file .env: $e");
    // Anda mungkin ingin menampilkan pesan error atau menggunakan nilai default
  }

  // Daftarkan AuthService sebagai service permanen
  // Ini harus dilakukan SETELAH .env dimuat (karena AuthService mungkin menggunakan EnvHelper)
  // dan SEBELUM runApp agar siap digunakan oleh controller/view
  Get.put(AuthService(), permanent: true);
  print("✅ AuthService berhasil didaftarkan.");

  // Jalankan aplikasi setelah .env selesai dimuat dan service didaftarkan
  runApp(
    GetMaterialApp(
      title: "Smart Attendance Students",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false, // Sebaiknya true selama development
    ),
  );
}
