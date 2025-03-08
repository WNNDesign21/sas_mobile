import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/dashboard_controller.dart';
import '../../../routes/app_pages.dart';
import '../../widget/animated_widgets.dart';
import '../../widget/sidebar_widget.dart'; // Import widget sidebar

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarWidget(), // Gunakan widget sidebar
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              _buildHeader(context),
              _buildStudentPhoto(),
              _buildCarouselSlider(),
              _buildFooter(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(53),
          bottomRight: Radius.circular(53),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(79, 1, 2, 0.99),
            Color.fromRGBO(151, 41, 54, 0.99),
            Color.fromRGBO(194, 0, 30, 1),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: MediaQuery.of(context).size.width / 2 - 70,
            child: Column(
              children: [
                Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balooBhai2(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Adhi Nur Fajar',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.balooBhai2(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 25,
            left: 20,
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 39),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 30,
            child: Image.asset(
              'assets/images/logosasputih.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentPhoto() {
    return const AnimatedStudentPhoto();
  }

  Widget _buildCarouselSlider() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 15),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
        ),
        items: controller.subjects.map((subject) {
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                AnimatedChart(subject: subject),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: subject["color"]!, width: 2),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      subject["name"],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFooter() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 75,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/navbar.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          child: GestureDetector(
            onTap: () async {
              //tambahkan async
              String? result = await Get.toNamed(Routes.QR); //tambahkan await
              //lakukan tindakan dengan data result
              print(result);
            },
            child: const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              radius: 35,
              child: Icon(Icons.qr_code_scanner, color: Colors.black, size: 40),
            ),
          ),
        ),
      ],
    );
  }
}
