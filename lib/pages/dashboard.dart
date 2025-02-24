import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
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

  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _slideAnimation =
        Tween<Offset>(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Sidebar (Drawer)
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFD9D9D9).withOpacity(0.5),
                Color(0xFFA5A5A5).withOpacity(0.5),
                Color(0xFFFFFFFF).withOpacity(0.5),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 80),
              Image.asset(
                'assets/images/sidebar.png',
                width: 100,
              ),
              SizedBox(height: 20),

              // 🔹 Tombol Sidebar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.home, color: Colors.white),
                    title: Text("Home", style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.white),
                    title:
                        Text("Profile", style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.white),
                    title: Text("Attendance",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    title:
                        Text("Setting", style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

              Spacer(),

              // 🔹 Tombol Logout
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade900,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title:
                        Text("Logout", style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      // Tambahkan aksi logout jika diperlukan
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // 🔹 Header + Hamburger Menu
      body: Stack(
        children: [
          Column(
            children: <Widget>[
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
                      left: 25,
                      child: Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu, color: Colors.white, size: 39),
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
                        'assets/images/logosasputih.png', // Pastikan file ada di dalam assets
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ),
              // 🔹 Box untuk Foto Mahasiswa + Background (Full & Responsif)
              Expanded(
                child: FadeTransition(
                  opacity: _animation,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // 🔹 Background Transparan di Belakang (Full di dalam box)
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.1,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/bgfix.png'),
                                  fit: BoxFit.cover,
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
                                image: AssetImage('images/adhi.png'),
                                fit: BoxFit.contain,
                              ),
                              boxShadow: [],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// 🔹 Grafik dalam Carousel Slider
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 15),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
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
                                      (index) => FlSpot(
                                        index.toDouble(),
                                        subject["data"][index].toDouble() *
                                            _animation.value,
                                      ),
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
                    bottom: 25,
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
