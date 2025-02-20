import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfileScreen(),
  ));
}

class ProfileScreen extends StatelessWidget {
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
                  top: 40,
                  left: MediaQuery.of(context).size.width / 2 - 95,
                  child: Column(
                    children: [
                      Text(
                        'Welcome',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Wendi Nugraha N',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 33,
                  left: 20,
                  child: Icon(Icons.menu, color: Colors.white, size: 39),
                ),
                Positioned(
                  top: 33,
                  right: 20,
                  child: Icon(Icons.logout, color: Colors.white, size: 39),
                ),
              ],
            ),
          ),

          // 🔹 Bagian Tengah (Background + Foto Mahasiswa)
          Expanded(
            child: Stack(
              children: [
                // 🔹 Background Gambar
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://source.unsplash.com/featured/?university,students'), // Ganti dengan URL gambar
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 🔹 Foto Mahasiswa (Bukan Bulat)
                Center(
                  child: Container(
                    width: 200,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://source.unsplash.com/featured/?student,profile'), // Ganti dengan URL gambar mahasiswa
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Grafik yang Bisa Digulir (Carousel)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
              items: [
                ChartContainer(title: "Pemrograman Web"),
                ChartContainer(title: "Data Science"),
                ChartContainer(title: "Machine Learning"),
              ],
            ),
          ),

          // 🔹 Footer
          Container(
            height: 60,
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home, color: Colors.red, size: 30),
                Icon(Icons.person, color: Colors.black54, size: 30),
                Icon(Icons.settings, color: Colors.black54, size: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 Widget Grafik
class ChartContainer extends StatelessWidget {
  final String title;

  ChartContainer({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: true),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 90),
                      FlSpot(1, 80),
                      FlSpot(2, 70),
                      FlSpot(3, 60),
                      FlSpot(4, 50),
                      FlSpot(5, 65),
                    ],
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    belowBarData: BarAreaData(show: false),
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
