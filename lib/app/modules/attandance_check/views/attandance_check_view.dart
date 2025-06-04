import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:table_calendar/table_calendar.dart'; // Jika Anda menggunakan package table_calendar
import 'package:intl/intl.dart';
import '../../widget/sidebar_widget.dart';
import '../controllers/attandance_check_controller.dart';
// Pastikan PertemuanAbsensiItem sudah didefinisikan di AttendanceController atau diimpor dari model jika ada
import '../../Attendance/controllers/attendance_controller.dart'
    show PertemuanAbsensiItem;

class AttandanceCheckView extends GetView<AttandanceCheckController> {
  const AttandanceCheckView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarWidget(),
      body: Stack(
        children: <Widget>[
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset('assets/images/bgfix.png', fit: BoxFit.cover),
            ),
          ),

          // Main Content Column
          Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),

              // Subject Title dari Controller
              Obx(
                () => Text(
                  controller.subjectTitle.value,
                  style: GoogleFonts.balooBhai2(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Calendar Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Month Title with Navigation
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Obx(
                          () => Row(
                            // Bungkus dengan Obx untuk _focusedDay
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.keyboard_arrow_left,
                                  size: 28,
                                ),
                                onPressed: () {
                                  controller.onPageChanged(
                                    DateTime(
                                      controller.focusedDay.value.year,
                                      controller.focusedDay.value.month - 1,
                                      1,
                                    ),
                                  );
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              Text(
                                DateFormat(
                                  'MMMM',
                                ).format(controller.focusedDay.value),
                                style: GoogleFonts.balooBhai2(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 28,
                                ),
                                onPressed: () {
                                  controller.onPageChanged(
                                    DateTime(
                                      controller.focusedDay.value.year,
                                      controller.focusedDay.value.month + 1,
                                      1,
                                    ),
                                  );
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Kalender
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        if (controller.errorMessage.value != null &&
                            controller.attendanceRecords.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                "Error: ${controller.errorMessage.value}",
                              ),
                            ),
                          );
                        }
                        // Custom Calendar Implementation
                        return _buildRealtimeCalendar(
                          controller.focusedDay.value,
                          controller.selectedDay.value,
                          controller.attendanceRecords,
                          controller.onDaySelected,
                          controller.getStatusColor,
                        );
                      }),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Notes Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Notes",
                        style: GoogleFonts.balooBhai2(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatusLegend("Present", Colors.green),
                          _buildStatusLegend("Absent", Colors.red),
                          _buildStatusLegend("Permit", Colors.cyan),
                        ],
                      ),
                    ],
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
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Get.back(),
                tooltip: 'Kembali',
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 50, right: 50),
                child: Obx(
                  () => Text(
                    // Judul header juga dari controller
                    controller.subjectTitle.value.isNotEmpty
                        ? controller.subjectTitle.value
                        : 'Attendance Check',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.balooBhai2(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 20,
              child: Image.asset(
                'assets/images/logosasputih.png',
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRealtimeCalendar(
    DateTime focusedDay,
    DateTime selectedDay,
    List<PertemuanAbsensiItem> attendanceRecords,
    Function(DateTime, DateTime) onDaySelected,
    Color Function(String) getStatusColor,
  ) {
    final DateTime firstDayOfMonth = DateTime(
      focusedDay.year,
      focusedDay.month,
      1,
    );
    final DateTime lastDayOfMonth = DateTime(
      focusedDay.year,
      focusedDay.month + 1,
      0,
    );
    final int firstWeekdayOfMonth =
        (firstDayOfMonth.weekday == 7)
            ? 0
            : firstDayOfMonth.weekday; // Minggu = 0
    final DateTime firstCalendarDay = firstDayOfMonth.subtract(
      Duration(days: firstWeekdayOfMonth),
    );

    final List<DateTime> calendarDays = [];
    for (int i = 0; i < 35; i++) {
      // Tampilkan 5 minggu saja seperti di foto
      calendarDays.add(firstCalendarDay.add(Duration(days: i)));
    }

    final List<List<DateTime>> calendarWeeks = [];
    for (int i = 0; i < calendarDays.length; i += 7) {
      calendarWeeks.add(calendarDays.sublist(i, i + 7));
    }

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          // Header hari dalam seminggu
          Container(
            margin: const EdgeInsets.all(0),
            child: Row(
              children:
                  ["S", "M", "T", "W", "T", "F", "S"]
                      .map(
                        (day) => Expanded(
                          child: Container(
                            height: 35,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xFFC2001E),
                            ),
                            child: Text(
                              day,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          // Baris-baris tanggal
          ...calendarWeeks.map(
            (week) => _buildCalendarWeekRow(
              week,
              focusedDay,
              selectedDay,
              attendanceRecords,
              onDaySelected,
              getStatusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarWeekRow(
    List<DateTime> days,
    DateTime focusedDay,
    DateTime selectedDay,
    List<PertemuanAbsensiItem> attendanceRecords,
    Function(DateTime, DateTime) onDaySelected,
    Color Function(String) getStatusColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            days.map((date) {
              final bool isCurrentMonth = date.month == focusedDay.month;
              final bool isToday = DateUtils.isSameDay(date, DateTime.now());
              final bool isSelected = DateUtils.isSameDay(date, selectedDay);

              PertemuanAbsensiItem? recordForDate;
              try {
                recordForDate = attendanceRecords.firstWhereOrNull(
                  (record) =>
                      DateUtils.isSameDay(DateTime.parse(record.tanggal), date),
                );
              } catch (e) {
                if (Get.isLogEnable) {
                  print(
                    "Error parsing date for record: ${e.toString()} for date ${date.toIso8601String()}",
                  );
                }
              }
              Color? statusColor;
              if (recordForDate != null) {
                statusColor = getStatusColor(recordForDate.status);
              }

              return GestureDetector(
                onTap: () {
                  onDaySelected(date, date);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        isSelected && statusColor == null
                            ? Border.all(color: Colors.blue, width: 2)
                            : (isToday && statusColor == null
                                ? Border.all(color: Colors.blue, width: 1)
                                : null),
                  ),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                      color:
                          statusColor != null
                              ? Colors.white
                              : (!isCurrentMonth
                                  ? Colors.grey.withOpacity(0.3)
                                  : (isSelected || isToday
                                      ? Colors.blue
                                      : Colors.black87)),
                      fontWeight:
                          statusColor != null || isToday || isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildStatusLegend(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
