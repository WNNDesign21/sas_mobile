import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';

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
      body: Column(
        children: <Widget>[
          // 🔹 Bagian Atas Merah (Header)
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 0),
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
                Positioned(
                  top: 25,
                  left: 20,
                  child: Icon(Icons.menu, color: Colors.white, size: 39),
                ),
                Positioned(
                  top: 25,
                  right: 20,
                  child: Icon(Icons.logout, color: Colors.white, size: 39),
                ),
              ],
            ),
          ),

          // 🔹 Box untuk Foto Mahasiswa + Background (Full & Responsif)
          Expanded(
            child: Container(
              width: double.infinity, // Box memenuhi lebar layar
              height: MediaQuery.of(context).size.height *
                  0.4, // Menyesuaikan layar
              padding: EdgeInsets.symmetric(
                horizontal: 0,
              ), // Jarak samping agar rapi
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 🔹 Background Transparan di Belakang (Full di dalam box)
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.3, // Opacity sesuai desain
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/bgfix.png'), // Background
                            fit: BoxFit.cover, // Background tidak terpotong
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 🔹 Foto Mahasiswa di Depan (Full tanpa terpotong)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('images/adhi.png'), // Foto mahasiswa
                          fit: BoxFit.contain, // Pastikan foto tidak terpotong
                        ),
                        boxShadow: [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 Grafik dalam Carousel Slider
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 15), // Menyesuaikan posisi
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200, // Sesuai desain
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {});
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
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: Colors.grey.withOpacity(0.3),
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: TextStyle(fontSize: 12),
                                    );
                                  },
                                  interval: 50,
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    List<String> months = [
                                      "Jan",
                                      "Feb",
                                      "Mar",
                                      "Apr",
                                      "Mei",
                                      "Jun"
                                    ];
                                    return Text(
                                      months[value.toInt()],
                                      style: TextStyle(fontSize: 12),
                                    );
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
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
                                dotData: FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) {
                                    return FlDotCirclePainter(
                                      radius: 5,
                                      color: Colors.white,
                                      strokeWidth: 1,
                                      strokeColor: subject["color"],
                                    );
                                  },
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: subject["color"]!.withOpacity(0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // 🔹 Legenda
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: subject["color"]!, width: 2),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            subject["name"],
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // 🔹 Tambahan Ikon Scan QR Code di Tengah Bawah Menyentuh Footer
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipPath(
                clipper: TopCurvedFooterClipper(),
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(79, 1, 2, 0.99),
                        Color.fromRGBO(151, 41, 54, 0.995),
                        Color.fromRGBO(194, 0, 30, 1),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 25, // Menyesuaikan QR Code agar menyentuh footer
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  radius: 35,
                  child: Icon(Icons.qr_code_scanner,
                      color: Colors.black, size: 40),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 🔹 Clipper untuk membuat lengkungan atas tengah
class TopCurvedFooterClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Sisi kiri atas dengan border radius
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.3);
    path.quadraticBezierTo(
        size.width * 0.2, 0, size.width * 0.3, size.height * 0.1);

    // Lengkungan ke bawah di tengah atas
    path.cubicTo(size.width * 0.6, size.height * 0.6, size.width * 0.6,
        size.height * 0.1, size.width * 0.8, 0);

    // Sisi kanan atas dengan border radius
    path.quadraticBezierTo(size.width * 0.89, 0, size.width, size.height * 0.2);
    path.lineTo(size.width, size.height);

    // Bagian bawah harus rata
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TopCurvedFooterClipper oldClipper) => false;
}
