import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/sidebar_widget.dart';
import '../controllers/schedule_controller.dart';
import '../../../data/models/schedule_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarWidget(),
      body: Stack(
        children: [
          // 🔹 Background Image with Opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/bgfix.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Obx(
                  () => Center(
                    // Wrap ListView.builder with Center
                    child: ListView.builder(
                      padding: const EdgeInsets.all(25),
                      itemCount: controller.schedules.length,
                      itemBuilder: (context, index) {
                        final schedule = controller.schedules[index];
                        return Center(
                          //Center per Item
                          child: ScheduleBoxWithShadow(schedule: schedule),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 110,
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
            top: 48,
            left: MediaQuery.of(context).size.width / 2 - 63,
            child: Text(
              'Schedule',
              textAlign: TextAlign.center,
              style: GoogleFonts.balooBhai2(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 35),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          Positioned(
            top: 47,
            right: 30,
            child: Image.asset(
              'assets/images/logosasputih.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget baru untuk menambahkan efek bayangan
class ScheduleBoxWithShadow extends StatelessWidget {
  final ScheduleModel schedule;

  const ScheduleBoxWithShadow({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Box bayangan (shadow)
          Positioned(
            top: 2, // Geser ke bawah
            left: 0, // Geser ke kanan
            child: Opacity(
              opacity: 0.4, // Mengurangi opacity box bayangan
              child: Container(
                width: 310,
                height: 151,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(33)),
                    color: const Color.fromARGB(
                        255, 196, 52, 52)), // Warna bayangan yang lebih soft
              ),
            ),
          ),
          // Box utama
          Opacity(
            opacity: 0.8, // Mengurangi opacity box utama
            child: ScheduleBox(schedule: schedule),
          ),
        ],
      ),
    );
  }
}

class ScheduleBox extends StatelessWidget {
  final ScheduleModel schedule;

  const ScheduleBox({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: 310,
      height: 151,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 310,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(33)),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(220, 19, 26, 73),
                    Color.fromARGB(240, 128, 37, 37),
                    Color.fromARGB(240, 128, 37, 37),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 43,
            left: 15,
            child: Text(
              schedule.day,
              textAlign: TextAlign.center,
              style: GoogleFonts.baloo2(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 15,
            child: Text(
              schedule.time,
              textAlign: TextAlign.center,
              style: GoogleFonts.baloo2(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ),
          Positioned(
            top: 97,
            left: 15,
            child: Text(
              schedule.location,
              textAlign: TextAlign.center,
              style: GoogleFonts.baloo2(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ),
          Positioned(
            top: 18,
            left: 15,
            child: SizedBox(
              width: 310,
              height: 31,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Text(
                      schedule.subject,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.baloo2(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
