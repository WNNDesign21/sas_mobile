import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _subjects = [
    {
      "name": "Pemrograman Web",
      "data": [90, 85, 80, 75, 60, 65],
      "color": Colors.blue,
    },
    {
      "name": "Pemrograman Mobile",
      "data": [70, 75, 80, 85, 90, 95],
      "color": Colors.green,
    },
    {
      "name": "Data Science",
      "data": [60, 65, 70, 75, 80, 85],
      "color": Colors.orange,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background Image
          Positioned.fill(
            child: Image.asset(
              'images/bgloginfix.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Layout Content
          SafeArea(
            child: Column(
              children: [
                // 🔹 Header dengan Foto Mahasiswa
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Menu Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.menu, color: Colors.white, size: 32),
                          Column(
                            children: [
                              Text(
                                "Welcome",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Wendi Nugraha N",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.logout, color: Colors.white, size: 32),
                        ],
                      ),

                      SizedBox(height: 10),

                      // 🔹 Foto Mahasiswa (Stacked)
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 58,
                              backgroundImage: AssetImage('images/student.jpg'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // 🔹 Grafik dalam Carousel Slider
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
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
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            subject["name"],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: subject["color"],
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(show: false),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        switch (value.toInt()) {
                                          case 0:
                                            return Text("Jan",
                                                style: TextStyle(fontSize: 12));
                                          case 1:
                                            return Text("Feb",
                                                style: TextStyle(fontSize: 12));
                                          case 2:
                                            return Text("Mar",
                                                style: TextStyle(fontSize: 12));
                                          case 3:
                                            return Text("Apr",
                                                style: TextStyle(fontSize: 12));
                                          case 4:
                                            return Text("Mei",
                                                style: TextStyle(fontSize: 12));
                                          case 5:
                                            return Text("Jun",
                                                style: TextStyle(fontSize: 12));
                                          default:
                                            return Text("");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: List.generate(
                                      subject["data"].length,
                                      (index) => FlSpot(index.toDouble(),
                                          subject["data"][index].toDouble()),
                                    ),
                                    isCurved: true,
                                    color: subject["color"],
                                    dotData: FlDotData(show: true),
                                    belowBarData: BarAreaData(show: false),
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

                SizedBox(height: 10),

                // 🔹 Indicator Carousel
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _subjects.map((subject) {
                    int index = _subjects.indexOf(subject);
                    return Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentIndex == index ? Colors.red : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),

                // 🔹 Tombol Scan QR
                GestureDetector(
                  onTap: () {
                    // Tambahkan fungsi Scan QR
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 32,
                    ),
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
