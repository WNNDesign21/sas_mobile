import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingLoginScreen {
  LoadingLoginScreen._();

  static void showLoading() {
    Get.dialog(
      const _LoadingLoginScreenWidget(),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}

class _LoadingLoginScreenWidget extends StatefulWidget {
  const _LoadingLoginScreenWidget();

  @override
  State<_LoadingLoginScreenWidget> createState() =>
      _LoadingLoginScreenWidgetState();
}

class _LoadingLoginScreenWidgetState extends State<_LoadingLoginScreenWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  //late Animation<double> _scaleAnimation; // Hapus animasi scale
  late Animation<double> _opacityAnimation;
  late Animation<double> _offsetAnimation; // Animasi offset (kanan-kiri)

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 3), // Durasi 2 detik untuk 1 siklus animasi
    )..repeat(reverse: true); // Animasi repeat dan reverse

    _opacityAnimation = Tween<double>(
      begin: 1.0, // Mulai dengan opacity 80%
      end: 1.0, // Berakhir dengan opacity 100%
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _offsetAnimation = Tween<double>(
      begin: -20.0, // Mulai dari kiri -20.0
      end: 20.0, // Berakhir di kanan 20.0
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves
            .easeInOut)); //menggunakan Curve.easeInOut pada saat di offset
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'images/bgloginfix.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Konten Loading (Logo, Text)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ganti Lottie dengan AnimatedBuilder dan Transform.translate
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _opacityAnimation.value,
                        child: Transform.translate(
                          offset: Offset(_offsetAnimation.value,
                              0.0), // Animasi kanan-kiri
                          child: Image.asset(
                            'images/logo.png', // Logo aplikasi
                            width: 200, // Sesuaikan ukuran logo
                            height: 200,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Loading...",
                    style: TextStyle(
                      color: Color.fromARGB(255, 180, 0, 0),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
