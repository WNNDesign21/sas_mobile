// lib/utils/env_helper.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Helper class untuk mengakses variabel lingkungan (.env).
class EnvHelper {
  // Private constructor agar kelas ini tidak bisa diinstansiasi.
  EnvHelper._();

  /// Mengambil Base URL API dari environment variable 'API_BASE_URL'.
  ///
  /// Memberikan nilai default string kosong jika tidak ditemukan,
  /// namun idealnya variabel ini HARUS ada di file .env Anda.
  static String get apiBaseUrl {
    // Pastikan 'API_BASE_URL' sesuai dengan nama variabel di file .env Anda
    return dotenv.env['API_BASE_URL'] ?? '';
  }

  // --- Tambahkan getter statis lainnya untuk variabel .env lain jika perlu ---
  // Contoh:
  // static String get apiKey {
  //   return dotenv.env['API_KEY'] ?? 'DEFAULT_API_KEY';
  // }
}
