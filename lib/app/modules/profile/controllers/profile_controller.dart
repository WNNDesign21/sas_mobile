// d:\kuliah\sas_mobile\lib\app\modules\profile\controllers\profile_controller.dart
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart'; // Untuk kDebugMode
import 'package:flutter/material.dart'; // Import Material library for Colors
import 'dart:io'; // Untuk File
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart'; // Import image_picker

import '../../../services/auth_service.dart'; // Pastikan path ini benar
import '../../../utils/env_helper.dart'; // Pastikan path ini benar

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  // State untuk data profil
  final RxString name = "Memuat...".obs;
  final RxString idNumber = "Memuat...".obs; // NPM
  final RxString faculty = "Memuat...".obs; // Fakultas
  final RxString study = "Memuat...".obs; // Prodi
  final RxString profileImageRelativePath =
      ''.obs; // Menyimpan path relatif dari API

  // State untuk UI
  final RxBool isLoading = true.obs;
  final RxnString errorMessage = RxnString(null);
  final RxBool isUploading = false.obs; // State untuk loading upload foto
  final RxInt imageCacheBuster =
      0.obs; // Digunakan untuk memaksa refresh gambar

  // Getter untuk URL gambar lengkap
  String get profileImageUrl {
    if (profileImageRelativePath.value.isEmpty) {
      return ''; // Atau URL placeholder default jika ada
    }
    final apiBaseUrl = EnvHelper.apiBaseUrl;
    if (apiBaseUrl.isEmpty) {
      if (kDebugMode) {
        print("ProfileController: API Base URL is empty in EnvHelper.");
      }
      return '';
    }
    // Buat base URL server (hapus '/api' atau '/api/' di akhir)
    String serverBaseUrl = apiBaseUrl;
    if (serverBaseUrl.endsWith('/api/')) {
      serverBaseUrl = serverBaseUrl.substring(
        0,
        serverBaseUrl.length - '/api/'.length,
      );
    } else if (serverBaseUrl.endsWith('/api')) {
      serverBaseUrl = serverBaseUrl.substring(
        0,
        serverBaseUrl.length - '/api'.length,
      );
    }
    // Gabungkan base URL server dengan path relatif gambar
    final fullUrl =
        '$serverBaseUrl/${profileImageRelativePath.value.startsWith('/') ? profileImageRelativePath.value.substring(1) : profileImageRelativePath.value}?v=${imageCacheBuster.value}';
    if (kDebugMode) {
      print("ProfileController: Constructed profileImageUrl: $fullUrl");
    }
    return fullUrl;
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final String? userId = _authService.currentUserId.value;
      if (userId == null || userId.isEmpty) {
        throw Exception("User ID tidak tersedia. Silakan login kembali.");
      }

      final baseUrl = EnvHelper.apiBaseUrl;
      if (baseUrl.isEmpty) {
        throw Exception("API Base URL tidak dikonfigurasi.");
      }

      final uri = Uri.parse(
        '$baseUrl/profil',
      ).replace(queryParameters: {'id_user': userId});

      if (kDebugMode) {
        print('--- API Get Profile Request ---');
        print('URL: $uri');
        print('Method: GET');
        print('-----------------------------');
      }

      final response = await http
          .get(uri, headers: {'Accept': 'application/json'})
          .timeout(const Duration(seconds: 20));

      if (kDebugMode) {
        print('--- API Get Profile Response ---');
        print('Status Code: ${response.statusCode}');
        print('Body: ${response.body}');
        print('------------------------------');
      }

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['status'] == true && responseBody['data'] != null) {
          final data = responseBody['data'] as Map<String, dynamic>;
          name.value = data['nama'] ?? 'Tidak ada data';
          idNumber.value = data['npm'] ?? 'Tidak ada data';
          faculty.value = data['fakultas'] ?? 'Tidak ada data';
          study.value = data['prodi'] ?? 'Tidak ada data';
          profileImageRelativePath.value = data['foto_profil'] ?? '';
        } else {
          throw Exception(
            responseBody['message'] ?? "Gagal memuat data profil.",
          );
        }
      } else {
        throw Exception(
          responseBody['message'] ?? "Error server: ${response.statusCode}",
        );
      }
    } on TimeoutException catch (_) {
      errorMessage.value = "Waktu koneksi habis. Periksa internet Anda.";
      _setDefaultProfileValuesOnError();
    } catch (e) {
      errorMessage.value = "Terjadi kesalahan: ${e.toString()}";
      _setDefaultProfileValuesOnError();
      if (kDebugMode) {
        print("❌ Error fetching profile data: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _setDefaultProfileValuesOnError() {
    name.value = "Gagal memuat";
    idNumber.value = "-";
    faculty.value = "-";
    study.value = "-";
    profileImageRelativePath.value = '';
  }

  Future<void> pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        File imageFile = File(image.path);
        // Tambahkan pengecekan file di sini
        if (kDebugMode) {
          bool fileExists = await imageFile.exists();
          int fileLength = fileExists ? await imageFile.length() : -1;
          print(
            "Image picked: ${imageFile.path}, exists: $fileExists, length: $fileLength bytes",
          );
        }
        if (!await imageFile.exists()) {
          Get.snackbar(
            "Error",
            "File gambar yang dipilih tidak ditemukan atau tidak dapat diakses.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return; // Hentikan jika file tidak ada
        }
        await _uploadProfilePicture(imageFile);
      } else {
        Get.snackbar(
          "Info",
          "Pemilihan gambar dibatalkan.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal memilih gambar: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      if (kDebugMode) {
        print("Error picking image: $e");
      }
    }
  }

  Future<void> _uploadProfilePicture(File imageFile) async {
    isUploading.value = true;
    errorMessage.value = null;
    http.MultipartRequest? requestLog; // Untuk logging jika terjadi error

    try {
      final String? userId = _authService.currentUserId.value;
      if (userId == null || userId.isEmpty) {
        throw Exception("User ID tidak tersedia.");
      }

      final baseUrl = EnvHelper.apiBaseUrl;
      if (baseUrl.isEmpty) {
        throw Exception("API Base URL tidak dikonfigurasi.");
      }

      final uri = Uri.parse('$baseUrl/profil/upload_foto');
      var request = http.MultipartRequest('POST', uri);
      requestLog = request; // Simpan referensi untuk logging
      request.fields['id_user'] = userId;

      if (kDebugMode) {
        print("Preparing to add file to request: ${imageFile.path}");
      }
      http.MultipartFile multipartFile;
      try {
        multipartFile = await http.MultipartFile.fromPath(
          'foto_profil', // Nama field sesuai API
          imageFile.path,
        );
        request.files.add(multipartFile);
        if (kDebugMode) {
          print(
            "File added to request successfully: ${multipartFile.filename}, length: ${multipartFile.length}",
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print("❌ Error creating MultipartFile from path: $e");
        }
        throw Exception("Gagal memproses file gambar: ${e.toString()}");
      }

      if (kDebugMode) {
        print('--- API Upload Foto Profil Request ---');
        print('URL: $uri');
        print('Method: POST');
        print('Fields: ${request.fields}');
        if (request.files.isNotEmpty) {
          print('File name: ${request.files.first.filename}');
          print('File length: ${request.files.first.length}');
        }
        print('------------------------------------');
      }

      if (kDebugMode) {
        print("Attempting to send request...");
      }
      var streamedResponse = await request.send().timeout(
        const Duration(seconds: 60),
      );
      if (kDebugMode) {
        print("Request sent, awaiting response from stream...");
      }
      var response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print("Response received from stream.");
      }

      if (kDebugMode) {
        print('--- API Upload Foto Profil Response ---');
        print('Status Code: ${response.statusCode}');
        print('Body: ${response.body}');
        print('-------------------------------------');
      }

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['status'] == true) {
        String newFotoProfilUrl = responseBody['foto_profil'] ?? '';
        if (newFotoProfilUrl.isNotEmpty) {
          if (kDebugMode) {
            print("New Foto Profil URL from API: $newFotoProfilUrl");
            print("Current EnvHelper.apiBaseUrl: ${EnvHelper.apiBaseUrl}");
          }
          try {
            Uri fullUrlFromServer = Uri.parse(newFotoProfilUrl);
            String serverAssetBase = EnvHelper.apiBaseUrl.replaceAll(
              RegExp(r'/api/?$'),
              '',
            );
            Uri serverBaseUri = Uri.parse(serverAssetBase);
            if (kDebugMode) {
              print("Derived Server Asset Base: $serverAssetBase");
            }

            if (fullUrlFromServer.scheme == serverBaseUri.scheme &&
                fullUrlFromServer.host == serverBaseUri.host &&
                fullUrlFromServer.port == serverBaseUri.port &&
                fullUrlFromServer.path.startsWith(serverBaseUri.path)) {
              profileImageRelativePath.value = fullUrlFromServer.path
                  .substring(serverBaseUri.path.length)
                  .replaceAll(RegExp(r'^/+'), '');
              if (kDebugMode) {
                print(
                  "Relative path (base URL match): ${profileImageRelativePath.value}",
                );
              }
            } else {
              profileImageRelativePath.value = fullUrlFromServer.path
                  .replaceAll(RegExp(r'^/+'), '');
              if (kDebugMode) {
                print("Base URL mismatch details:");
                print(
                  "  ServerFull: ${fullUrlFromServer.scheme}://${fullUrlFromServer.host}:${fullUrlFromServer.port}${fullUrlFromServer.path}",
                );
                print(
                  "  DerivedBase: ${serverBaseUri.scheme}://${serverBaseUri.host}:${serverBaseUri.port}${serverBaseUri.path}",
                );
                print(
                  "Warning: Base URL mismatch. Using full path from server URL as relative path: ${profileImageRelativePath.value}",
                );
              }
            }
          } catch (e) {
            if (kDebugMode) {
              print(
                "Error parsing new profile image URL or determining relative path: $e. Attempting simpler extraction.",
              );
            }
            if (newFotoProfilUrl.contains('/assets/')) {
              profileImageRelativePath.value = newFotoProfilUrl
                  .substring(newFotoProfilUrl.indexOf('/assets/') + 1)
                  .replaceAll(RegExp(r'^/+'), '');
              if (kDebugMode) {
                print(
                  "Relative path (fallback '/assets/'): ${profileImageRelativePath.value}",
                );
              }
            } else {
              profileImageRelativePath.value = '';
              if (kDebugMode) {
                print(
                  "Could not determine relative path using '/assets/' fallback.",
                );
                print(
                  "Could not determine relative path from newFotoProfilUrl: $newFotoProfilUrl",
                );
              }
            }
          }
        } else {
          profileImageRelativePath.value = '';
          if (kDebugMode) {
            print(
              "newFotoProfilUrl was empty. Setting relative path to empty.",
            );
          }
        }

        Get.snackbar(
          "Sukses",
          responseBody['message'] ?? "Foto profil berhasil diubah.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await fetchProfileData();
        imageCacheBuster.value++;
      } else {
        throw Exception(
          responseBody['message'] ??
              "Gagal mengunggah foto profil (Status: ${response.statusCode}).",
        );
      }
    } catch (e) {
      errorMessage.value = "Gagal mengunggah foto: ${e.toString()}";
      Get.snackbar(
        "Error",
        errorMessage.value!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      if (kDebugMode) {
        print("❌ Error uploading profile picture: $e");
        if (requestLog != null) {
          print(
            "Request details during error: URL=${requestLog.url}, Method=${requestLog.method}, Fields=${requestLog.fields}, Files=${requestLog.files.map((f) => f.filename ?? 'unknown_filename').toList()}",
          );
        }
      }
    } finally {
      isUploading.value = false;
    }
  }
}
