// lib/app/modules/widget/animated_widgets.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart'; // Pastikan fl_chart ada di pubspec.yaml
import '../dashboard/controllers/dashboard_controller.dart'; // Pastikan path ini benar

// Widget Student Photo (Menampilkan dari URL di Controller)
class AnimatedStudentPhoto extends GetView<DashboardController> {
  const AnimatedStudentPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background tetap sama
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/bgfix.png',
                      ), // Pastikan path asset benar
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),

            // Tampilkan Foto atau Placeholder berdasarkan URL dari Controller
            Obx(() {
              // Ambil URL gambar yang sudah dikonstruksi dari controller
              final imageUrl = controller.profileImageUrl.value;

              // 1. Tampilkan placeholder jika URL gambar kosong
              if (imageUrl.isEmpty) {
                // Animasi untuk placeholder (opsional, bisa juga langsung tampil)
                return AnimatedOpacity(
                  opacity: 1.0,
                  duration: controller.animationDuration,
                  curve: Curves.easeInOut,
                  child: const Center(
                    child: Icon(
                      Icons.person_outline, // Icon placeholder
                      size: 80, // Ukuran icon
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              // 2. Jika URL ada, tampilkan gambar dari network
              else {
                // Gunakan animasi yang sudah ada
                return AnimatedOpacity(
                  opacity: 1.0, // Langsung tampilkan
                  duration: controller.animationDuration,
                  curve: Curves.easeInOut,
                  child: AnimatedSlide(
                    offset: Offset.zero, // Langsung di posisi
                    duration: controller.animationDuration,
                    curve: Curves.easeInOut,
                    child: Image.network(
                      imageUrl, // Ambil URL dari controller
                      fit: BoxFit.contain, // Sesuaikan fit sesuai kebutuhan
                      // Tampilkan loading indicator saat gambar diunduh
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Gambar selesai
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null, // Tampilkan progress jika ada
                          ),
                        );
                      },
                      // Tampilkan placeholder jika gambar gagal dimuat dari URL
                      errorBuilder: (context, error, stackTrace) {
                        // Log error
                        // Get.log("Error loading image: $error", isError: true); // Diganti dengan print jika Get.log tidak tampil
                        print(
                          "AnimatedStudentPhoto: Error loading image: $error",
                        );
                        return const Center(
                          child: Icon(
                            Icons.broken_image_outlined, // Icon error gambar
                            size: 80,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class AnimatedChart extends GetView<DashboardController> {
  final List<Map<String, dynamic>> subject;

  const AnimatedChart({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: controller.chartAnimation,
        builder: (context, child) {
          if (subject.isEmpty) {
            return const Center(
              child: Text("Tidak ada data chart untuk ditampilkan"),
            );
          }

          final List<FlSpot> allSpots = [];
          List<String> subjectNames = [];

          // Loop untuk membuat FlSpot untuk setiap mata kuliah
          for (int i = 0; i < subject.length; i++) {
            var seriesData = subject[i];
            final List<dynamic>? dataPoints = seriesData["data"];
            final String seriesName =
                seriesData["name"] as String? ?? "Unknown";

            subjectNames.add(seriesName);

            if (dataPoints == null || dataPoints.isEmpty) {
              continue;
            }

            List<double> validData;
            try {
              validData = dataPoints.map((e) => (e as num).toDouble()).toList();
            } catch (e) {
              continue;
            }

            allSpots.add(
              FlSpot(
                i.toDouble(),
                validData[0] * controller.chartAnimation.value,
              ),
            );
          }

          if (allSpots.isEmpty) {
            return const Center(
              child: Text("Data chart tidak valid setelah diproses"),
            );
          }

          // Warna ungu yang sesuai dengan desain
          const Color purpleLineColor = Color.fromARGB(255, 122, 107, 253);

          // Membuat satu LineChartBarData dengan semua spot
          final mainLineBarData = LineChartBarData(
            spots: allSpots,
            isCurved: true,
            // Menggunakan gradient untuk warna garis
            gradient: const LinearGradient(
              colors: [
                // Membuat bagian tengah lebih terang
                purpleLineColor, // Start color
                Color.fromARGB(
                  255,
                  180,
                  160,
                  255,
                ), // Brighter middle color (example)
                purpleLineColor, // End color (can be same as start)
              ],
              stops: [0.0, 0.5, 1.0], // Mengatur transisi gradient
              begin: Alignment.centerLeft, // Arah gradient
              end: Alignment.centerRight,
            ),
            barWidth: 6, // Naikkan sedikit barWidth
            isStrokeCapRound: true,
            // Menambahkan shadow untuk efek glow
            shadow: Shadow(
              blurRadius:
                  12.0, // Tingkatkan blurRadius untuk glow yang lebih menyebar
              color: purpleLineColor.withOpacity(
                0.8, // Naikkan opacity shadow agar lebih terlihat
              ),
              offset: const Offset(0, 0), // Tidak ada offset agar glow merata
            ),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 5,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: purpleLineColor,
                );
              },
            ),
            // Hapus atau nonaktifkan belowBarData jika tidak ingin ada area di bawah garis
            belowBarData: BarAreaData(show: false),
            /* Jika tetap ingin ada area di bawah dengan gradient berbeda:
            belowBarData: BarAreaData(
              show: true, // Atur ke true jika ingin area di bawah garis
              gradient: LinearGradient( // Gradient untuk area di bawah garis
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  purpleLineColor.withOpacity(0.4),
                  purpleLineColor.withOpacity(0.05),
                ],
                stops: const [0, 1],
              ),
            ),
            */
          );

          return LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                drawHorizontalLine: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.15),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.15),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      // Only show specific values like 0, 50, 100
                      if (value % 50 == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            value.toStringAsFixed(0),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                    interval: 25.0,
                  ),
                ),
                bottomTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      final flSpot = barSpot;
                      String subjectName;
                      int subjectIndex = flSpot.x.toInt();
                      if (subjectIndex >= 0 &&
                          subjectIndex < subjectNames.length) {
                        subjectName = subjectNames[subjectIndex];
                      } else {
                        subjectName = 'Unknown';
                      }
                      return LineTooltipItem(
                        '$subjectName\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: (flSpot.y / controller.chartAnimation.value)
                                .toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.yellow,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(
                            text: '%',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                  // tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                ),
                handleBuiltInTouches: true,
              ),
              backgroundColor: Colors.white,
              minX: 0,
              maxX:
                  (subjectNames.isNotEmpty ? subjectNames.length - 1 : 0)
                      .toDouble(),
              minY: 0.0,
              maxY: 100.0,
              lineBarsData: [mainLineBarData],
            ),
          );
        },
      ),
    );
  }
}
