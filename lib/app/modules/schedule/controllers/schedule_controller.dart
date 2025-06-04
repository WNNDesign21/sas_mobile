import 'package:get/get.dart';
import '../../../data/models/schedule_model.dart';

class ScheduleController extends GetxController {
  final schedules = <ScheduleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Example data (replace with your actual data source)
    loadSchedules();
  }

  void loadSchedules() {
    schedules.addAll([
      ScheduleModel(
        day: 'Monday',
        time: '18.30 - 22.10 Wib',
        location: 'Lab A - Room B2-1',
        subject: 'Web Programming 2',
      ),
      ScheduleModel(
        day: 'Tuesday',
        time: '18.30 - 22.10 Wib',
        location: 'Lab A - Room B2-1',
        subject: 'Mobile Programming 2',
      ),
      ScheduleModel(
        day: 'Wednesday',
        time: '18.30 - 22.10 Wib',
        location: 'Lab A - Room B2-1',
        subject: 'Information System Analysis & Design',
      ),
      ScheduleModel(
        day: 'Thursday',
        time: '18.30 - 22.10 Wib',
        location: 'Lab A - Room B2-1',
        subject: 'Mobile Project',
      ),
      ScheduleModel(
        day: 'Thursday',
        time: '17.00 - 18.30 Wib',
        location: 'Lab A - Room B2-1',
        subject: 'Statistic',
      ),
      ScheduleModel(
        day: 'Friday',
        time: '18.00 - 19.30 Wib',
        location: 'Lab A - Room B2-1',
        subject: 'GWEP 4',
      ),
      ScheduleModel(
        day: 'Friday',
        time: '19.30 - 22.10 Wib',
        location: 'Lab A - Room B2-1',
        subject: 'Office Apps',
      ),
      ScheduleModel(
        day: 'Saturday',
        time: '18.30 - 22.10 Wib',
        location: 'Lab A - Room B2-1',
        subject: 'Java OOP',
      ),
    ]);
  }

  void addSchedule(ScheduleModel newSchedule) {
    schedules.add(newSchedule);
  }
}
