import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../dashboard/controllers/dashboard_controller.dart';

// Widget Student Photo
class AnimatedStudentPhoto extends GetView<DashboardController> {
  const AnimatedStudentPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/bgfix.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => AnimatedOpacity(
                opacity: controller.showStudentPhoto.value ? 1.0 : 0.0,
                duration: controller.animationDuration,
                curve: Curves.easeInOut,
                child: AnimatedSlide(
                  offset: controller.showStudentPhoto.value
                      ? const Offset(0, 0)
                      : const Offset(0, 1),
                  duration: controller.animationDuration,
                  curve: Curves.easeInOut,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/adhi.png'),
                        fit: BoxFit.contain,
                      ),
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
}

//widget Chart
class AnimatedChart extends GetView<DashboardController> {
  final Map<String, dynamic> subject;

  const AnimatedChart({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: controller.chartAnimation,
          builder: (context, child) {
            return LineChart(
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
                  show:
                      true, // tampilkan judul, hapus ini jika ingin menghapus semua judul
                  topTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: false), //hilangkan judul atas
                  ),
                  rightTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: false), //hilangkan judul kanan
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true, // Tampilkan judul kiri
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toStringAsFixed(
                              0), //Menampilkan nilai tanpa desimal
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                      interval: 50.0, //atur interval agar tidak terlalu rapat
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true, // Tampilkan judul bawah
                        getTitlesWidget: (value, meta) {
                          const List<String> months = [
                            "W-1",
                            "W-2",
                            "W-3",
                            "W-4",
                            "W-5",
                            "W-6",
                          ];
                          int index = value.round();
                          return Text(
                            months[index.clamp(0, months.length - 1)],
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                        interval: 1.0 //atur interval agar sesuai dengan data
                        ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
                minX: 0.0,
                maxX: 5.0,
                minY: 0.0,
                maxY: 100.0,
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      subject["data"].length,
                      (index) => FlSpot(
                        index.toDouble(),
                        (subject["data"][index] as double) *
                            controller.chartAnimation.value,
                      ),
                    ),
                    isCurved: true,
                    color: subject["color"],
                    barWidth: 4,
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
            );
          },
        ),
      ),
    );
  }
}
