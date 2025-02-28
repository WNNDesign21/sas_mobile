import 'dart:ui'; // Pastikan untuk mengimpor dart:ui untuk menggunakan ImageFilter
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sas_project/pages/qr.dart';
import 'package:sas_project/pages/profile.dart'; // Import profile.dart

class Dashboard extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _subjects = [
    {
      "name": "Pemrograman Web",
      "data": [90.0, 85.0, 80.0, 75.0, 60.0, 65.0],
      "color": Colors.purple,
    },
    {
      "name": "Pemrograman Mobile",
      "data": [90.0, 85.0, 80.0, 75.0, 60.0, 65.0],
      "color": Colors.purple,
    },
    {
      "name": "Data Science",
      "data": [90.0, 85.0, 80.0, 75.0, 60.0, 65.0],
      "color": Colors.purple,
    }
  ];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    // Animasi fade in
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Animasi slide dari bawah ke atas
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Mulai dari bawah
      end: Offset(0, 0), // Berakhir di posisi normal
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Animasi untuk grafik
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
      drawer: _buildDrawer(context),

      // 🔹 Header + Hamburger Menu
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

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      width: 200, // Lebar sidebar tetap
      backgroundColor:
          Colors.transparent, // Make the drawer background transparent
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(
              0.3), // Adjust opacity for desired transparency level
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Increased blur
            child: Column(
              children: [
                SizedBox(height: 70),
                Image.asset(
                  'assets/images/sidebar.png',
                  width: 170,
                ),
                SizedBox(height: 50),
                ..._buildDrawerItems(context),
                Spacer(),
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
      {"icon": Icons.home, "title": "Home", "route": "/dashboard"},
      {"icon": Icons.person, "title": "Profile", "route": "/profile"},
      {
        "icon": Icons.check_circle,
        "title": "Attendance",
        "route": "/attendance"
      },
      {"icon": Icons.settings, "title": "Setting", "route": "/setting"},
    ];

    return drawerItems.map((item) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 45, 28),
                Color.fromARGB(255, 205, 0, 0)
              ], // Warna gradient
              begin: Alignment.topCenter, // Gradient dari atas ke bawah
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListTile(
            leading: Icon(item["icon"], color: Colors.white),
            title: Text(item["title"], style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              if (item["route"] == "/profile") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileWidget()),
                );
              } else if (item["route"] == "/dashboard") {
                Navigator.pushReplacementNamed(context, '/dashboard');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Fitur ${item["title"]} belum tersedia')),
                );
              }
            },
          ),
        ),
      );
    }).toList();
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 45, 28),
              Color.fromARGB(255, 205, 0, 0)
            ], // Warna gradient
            begin: Alignment.topCenter, // Gradient dari atas ke bawah
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          leading: Icon(Icons.logout, color: Colors.white),
          title: Text("Logout", style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
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
                  'Christopan',
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
    );
  }

  Widget _buildStudentPhoto() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgfix.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation, // Cast to double,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/tangguh.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return Padding(
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
                                value.toStringAsFixed(
                                    1), // ✅ Ubah ke String dari Double
                                style: TextStyle(fontSize: 12),
                              );
                            },
                            interval: 50.0, // ✅ Pastikan double
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
                              int index = value
                                  .round(); // ✅ Gunakan round() untuk memastikan indeks valid
                              return Text(
                                months[index.clamp(
                                    0,
                                    months.length -
                                        1)], // ✅ Hindari error index out of range
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
                      minX: 0.0, // ✅ Ubah ke double
                      maxX: 5.0, // ✅ Ubah ke double
                      minY: 0.0, // ✅ Ubah ke double
                      maxY: 100.0, // ✅ Ubah ke double
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            subject["data"].length,
                            (index) => FlSpot(
                              index.toDouble(),
                              (subject["data"][index] as double) *
                                  _animation.value, // ✅ Dipastikan Double
                            ),
                          ),
                          isCurved: true,
                          color: subject["color"],
                          barWidth: 6,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
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
                            color: subject["color"]!.withOpacity(0.0),
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
                        border: Border.all(color: subject["color"]!, width: 2),
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
    );
  }

  Widget _buildFooter() {
    return Stack(
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
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScanqrWidget()),
              );
            },
            child: InkWell(
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                radius: 35,
                child:
                    Icon(Icons.qr_code_scanner, color: Colors.black, size: 40),
              ),
            ),
          ),
        ),
      ],
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
