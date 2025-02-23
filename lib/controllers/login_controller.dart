import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {
  final TextEditingController npmController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  // Simulasi proses login
  Future<void> login(BuildContext context) async {
    String npm = npmController.text.trim();
    String password = passwordController.text.trim();

    if (npm.isEmpty || password.isEmpty) {
      errorMessage = "NPM dan Password wajib diisi!";
      notifyListeners();
      return;
    }

    // Simulasi loading
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));

    // Simulasi autentikasi sukses
    if (npm == "12345678" && password == "123") {
      errorMessage = null;
      isLoading = false;
      notifyListeners();

      // 🔥 Navigasi ke dashboard setelah login berhasil
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      errorMessage = "NPM atau Password salah!";
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    npmController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
