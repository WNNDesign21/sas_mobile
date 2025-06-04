import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // Untuk kDebugMode

import '../../../services/auth_service.dart';
import '../../../utils/env_helper.dart';

// Definisikan struktur data langsung di sini jika tidak menggunakan model terpisah
class MataKuliahAbsensiItem {
  final String idMk;
  final String namaMk;
  final String sks;
  final int totalPertemuanMk;
  final int totalHadirMk;
  final double persentaseKehadiran;
  final List<PertemuanAbsensiItem> absensiPertemuan;

  MataKuliahAbsensiItem({
    required this.idMk,
    required this.namaMk,
    required this.sks,
    required this.totalPertemuanMk,
    required this.totalHadirMk,
    required this.persentaseKehadiran,
    required this.absensiPertemuan,
  });

  factory MataKuliahAbsensiItem.fromJson(Map<String, dynamic> json) {
    var listPertemuan = json['absensi_pertemuan'] as List;
    List<PertemuanAbsensiItem> pertemuanList =
        listPertemuan.map((i) => PertemuanAbsensiItem.fromJson(i)).toList();

    return MataKuliahAbsensiItem(
      idMk: json['id_mk'] ?? '',
      namaMk: json['nama_mk'] ?? 'N/A',
      sks: json['sks'] ?? 'N/A',
      totalPertemuanMk: json['total_pertemuan_mk'] ?? 0,
      totalHadirMk: json['total_hadir_mk'] ?? 0,
      persentaseKehadiran:
          (json['persentase_kehadiran'] as num?)?.toDouble() ?? 0.0,
      absensiPertemuan: pertemuanList,
    );
  }
}

class PertemuanAbsensiItem {
  final int pertemuan;
  final String
  tanggal; // Simpan sebagai String, parse ke DateTime jika perlu di UI
  final String status;
  final String idAbsensi;

  PertemuanAbsensiItem({
    required this.pertemuan,
    required this.tanggal,
    required this.status,
    required this.idAbsensi,
  });

  factory PertemuanAbsensiItem.fromJson(Map<String, dynamic> json) {
    return PertemuanAbsensiItem(
      pertemuan: json['pertemuan'] ?? 0,
      tanggal: json['tanggal'] ?? 'N/A',
      status: json['status'] ?? 'N/A',
      idAbsensi: json['id_absensi'] ?? '',
    );
  }
}

class AttendanceController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  // State untuk daftar data absensi mata kuliah
  final RxList<MataKuliahAbsensiItem> subjectsData =
      <MataKuliahAbsensiItem>[].obs;
  // State untuk UI
  final RxBool isLoading = true.obs;
  final RxnString errorMessage = RxnString(null);

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;
      subjectsData.clear();

      final String? userId = _authService.currentUserId.value;
      if (userId == null || userId.isEmpty) {
        throw Exception("User ID tidak tersedia. Silakan login kembali.");
      }

      final baseUrl = EnvHelper.apiBaseUrl;
      if (baseUrl.isEmpty) {
        throw Exception("API Base URL tidak dikonfigurasi.");
      }

      final uri = Uri.parse(
        '$baseUrl/absensi',
      ).replace(queryParameters: {'id_user': userId});

      if (kDebugMode) {
        print('--- API Get Subjects Request ---');
        print('URL: $uri');
        print('Method: GET');
        // Tambahkan header jika API memerlukan token otentikasi
        // print('Headers: ${AuthService.getAuthHeaders()}'); // Jika ada method untuk ini
        print('-----------------------------');
      }

      final response = await http
          .get(
            uri,
            headers: {
              'Accept': 'application/json',
              // Tambahkan header otentikasi jika diperlukan
              // 'Authorization': 'Bearer YOUR_TOKEN_HERE',
            },
          )
          .timeout(const Duration(seconds: 20));

      if (kDebugMode) {
        print('--- API Get Subjects Response ---');
        print('Status Code: ${response.statusCode}');
        print('Body: ${response.body}');
        print('------------------------------');
      }

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['status'] == true && responseBody['data'] != null) {
          final List<dynamic> dataList = responseBody['data'];
          subjectsData.value =
              dataList
                  .map(
                    (item) => MataKuliahAbsensiItem.fromJson(
                      item as Map<String, dynamic>,
                    ),
                  )
                  .toList();

          if (subjectsData.isEmpty) {
            errorMessage.value = "Tidak ada mata kuliah yang ditemukan.";
          }
        } else {
          throw Exception(
            responseBody['message'] ?? "Gagal memuat data mata kuliah.",
          );
        }
      } else {
        throw Exception(
          responseBody['message'] ?? "Error server: ${response.statusCode}",
        );
      }
    } on FormatException catch (e) {
      errorMessage.value = "Format data tidak sesuai: ${e.message}";
      if (kDebugMode) {
        print("❌ Error parsing subjects (FormatException): $e");
      }
    } catch (e) {
      errorMessage.value = "Terjadi kesalahan: ${e.toString()}";
      if (kDebugMode) {
        print("❌ Error fetching subjects: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
