  import 'dart:ui';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:google_fonts/google_fonts.dart';
  import '../../routes/app_pages.dart'; // Sesuaikan path routes

  class SidebarWidget extends StatelessWidget {
    const SidebarWidget({super.key});

    @override
    Widget build(BuildContext context) {
      return Drawer(
        width: 200,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Menghilangkan radius
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  Image.asset(
                    'assets/images/sidebar.png',
                    width: 170,
                  ),
                  const SizedBox(height: 50),
                  ..._buildDrawerItems(context),
                  const Spacer(),
                  _buildLogoutButton(context),
                ],
              ),
            ),
          ),
        ),
      );
    }

    List<Widget> _buildDrawerItems(BuildContext context) {
      final List<Map<String, dynamic>> drawerItems = [
        {
          "icon": Icons.home,
          "title": "Home",
          "route": Routes.DASHBOARD,
        },
        {
          "icon": Icons.person,
          "title": "Profile",
          "route": Routes.PROFILE,
        },
        {
          "icon": Icons.menu_book,
          "title": "Schedule",
          "route": Routes.SCHEDULE,
        },
        {
          "icon": Icons.check_circle,
          "title": "Attendance",
          "route": Routes.ATTENDANCE,
        },
        {
          "icon": Icons.settings,
          "title": "Setting",
          "route": Routes.SETTINGS,
        },
      ];

      return drawerItems.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 45, 28),
                  Color.fromARGB(255, 205, 0, 0)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListTile(
              leading: Icon(item["icon"], color: Colors.white),
              title: Text(
                item["title"],
                style: GoogleFonts.balooBhai2(color: Colors.white),
              ),
              onTap: () {
                Get.back();
                if (item["route"] == Routes.PROFILE) {
                  Get.toNamed(Routes.PROFILE);
                } else if (item["route"] == Routes.DASHBOARD) {
                  Get.offNamed(Routes.DASHBOARD);
                } else if (item["route"] == Routes.SETTINGS) {
                  Get.toNamed(Routes.SETTINGS);
                } else if (item["route"] == Routes.ATTENDANCE) {
                  Get.toNamed(Routes.ATTENDANCE);
                } else if (item["route"] == Routes.SCHEDULE) {
                  Get.toNamed(Routes.SCHEDULE);
                }
              },
            ),
          ),
        );
      }).toList();
    }

    Widget _buildLogoutButton(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 45, 28),
                Color.fromARGB(255, 205, 0, 0)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: Text("Logout",
                style: GoogleFonts.balooBhai2(color: Colors.white)),
            onTap: () {
              Get.back();
              Get.offAllNamed(Routes.LOGIN);
            },
          ),
        ),
      );
    }
  }
