import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class Dashboard extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<Dashboard> {
  final List<Map<String, dynamic>> _subjects = [
    {
      "name": "Pemrograman Web",
      "data": [90, 85, 80, 75, 60, 65],
      "color": Colors.purple,
    },
    {
      "name": "Pemrograman Mobile",
      "data": [90, 85, 80, 75, 60, 65],
      "color": Colors.purple,
    },
    {
      "name": "Data Science",
      "data": [90, 85, 80, 75, 60, 65],
      "color": Colors.purple,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 🔹 Sidebar
          SidebarWidget(),

          // 🔹 Main Content
          Expanded(
            child: Column(
              children: <Widget>[
                // 🔹 Header
                Container(
                  height: 120,
                  decoration: BoxDecoration(
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Adhi Nur Fajar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 🔹 Grafik dalam Carousel Slider
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 15),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                    ),
                    items: _subjects.map((subject) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(12),
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
                            SizedBox(height: 10),
                            Expanded(
                              child: LineChart(
                                LineChartData(
                                  minX: 0,
                                  maxX: 5,
                                  minY: 0,
                                  maxY: 100,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: List.generate(
                                        subject["data"].length,
                                        (index) => FlSpot(index.toDouble(),
                                            subject["data"][index].toDouble()),
                                      ),
                                      isCurved: true,
                                      color: subject["color"],
                                      barWidth: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 Sidebar Widget
class SidebarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 218,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(217, 217, 217, 1),
            Color.fromRGBO(164, 164, 164, 1),
            Color.fromRGBO(255, 255, 255, 1),
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 50),
          Image.asset('assets/images/Landscape3.png', width: 167, height: 46),
          SizedBox(height: 40),
          SidebarButton(iconPath: 'assets/images/Home.png', label: 'Home'),
          SidebarButton(
              iconPath: 'assets/images/Customer.png', label: 'Profile'),
          SidebarButton(
              iconPath: 'assets/images/Checkedusermale.png',
              label: 'Attendance'),
          SidebarButton(
              iconPath: 'assets/images/Settings.png', label: 'Settings'),
          Spacer(),
          SidebarButton(iconPath: 'assets/images/Logout.png', label: 'Logout'),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

// 🔹 Sidebar Button Widget
class SidebarButton extends StatelessWidget {
  final String iconPath;
  final String label;

  SidebarButton({required this.iconPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 167,
      height: 56,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color.fromRGBO(255, 0, 0, 1), Color.fromRGBO(153, 0, 0, 1)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: 30, height: 30),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Baloo 2',
            ),
          ),
        ],
      ),
    );
  }
}
