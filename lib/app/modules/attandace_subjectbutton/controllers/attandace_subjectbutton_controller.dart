import 'package:get/get.dart';

class AttandaceSubjectbuttonController extends GetxController {
  // State untuk menyimpan judul mata kuliah dan ID MK
  final RxString subjectTitle = ''.obs;
  final RxString subjectIdMk = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Ambil parameter dari GetX navigation
    final parameters = Get.parameters;
    subjectTitle.value = parameters['subjectTitle'] ?? 'Detail Mata Kuliah';
    subjectIdMk.value = parameters['idMk'] ?? '';

    // Anda bisa melakukan print untuk debugging
    // print("Received Subject Title: ${subjectTitle.value}");
    // print("Received Subject ID MK: ${subjectIdMk.value}");
  }
}
