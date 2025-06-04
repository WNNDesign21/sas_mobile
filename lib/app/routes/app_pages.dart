import 'package:get/get.dart';

import '../modules/Attendance/bindings/attendance_binding.dart';
import '../modules/Attendance/views/attendance_view.dart';
import '../modules/Qr/bindings/qr_binding.dart';
import '../modules/Qr/views/qr_view.dart';
import '../modules/attandace_subjectbutton/bindings/attandace_subjectbutton_binding.dart';
import '../modules/attandace_subjectbutton/views/attandace_subjectbutton_view.dart';
import '../modules/attandance_check/bindings/attandance_check_binding.dart';
import '../modules/attandance_check/views/attandance_check_view.dart';
import '../modules/attandance_early/bindings/attandance_early_binding.dart';
import '../modules/attandance_early/views/attandance_early_view.dart';
import '../modules/attandance_permit/bindings/attandance_permit_binding.dart';
import '../modules/attandance_permit/views/attandance_permit_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/keamanan_view/bindings/keamanan_view_binding.dart';
import '../modules/keamanan_view/views/keamanan_view_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lupa_pw/bindings/lupa_pw_binding.dart';
import '../modules/lupa_pw/views/lupa_pw_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/schedule/bindings/schedule_binding.dart';
import '../modules/schedule/views/schedule_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/ubah_sandi/bindings/ubah_sandi_binding.dart';
import '../modules/ubah_sandi/views/ubah_sandi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL =
      Routes.LOGIN; // Perubahan di sini, kita mulai dari login.

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.QR,
      page: () => const ScanqrWidget(),
      binding: ScanqrBinding(),
    ),
    GetPage(
      name: _Paths.KEAMANAN_VIEW,
      page: () => const KeamananViewView(),
      binding: KeamananViewBinding(),
    ),
    GetPage(
      name: _Paths.UBAH_SANDI,
      page: () => const UbahSandiView(),
      binding: UbahSandiBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PW,
      page: () => const LupaPwView(),
      binding: LupaPwBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE,
      page: () => const AttendanceView(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULE,
      page: () => const ScheduleView(),
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: _Paths.ATTANDACE_SUBJECTBUTTON,
      page: () => const AttandaceSubjectbuttonView(),
      binding: AttandaceSubjectbuttonBinding(),
    ),
    GetPage(
      name: _Paths.ATTANDANCE_CHECK,
      page: () => const AttandanceCheckView(),
      binding: AttandanceCheckBinding(),
    ),
    GetPage(
      name: _Paths.ATTANDANCE_EARLY,
      page: () => const AttandanceEarlyView(),
      binding: AttandanceEarlyBinding(),
    ),
    GetPage(
      name: _Paths.ATTANDANCE_PERMIT,
      page: () => const AttandancePermitView(),
      binding: AttandancePermitBinding(),
    ),
  ];
}
