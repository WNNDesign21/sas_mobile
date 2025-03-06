import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends ChangeNotifier {
  // Controllers for text fields
  TextEditingController namaController = TextEditingController();
  TextEditingController npmController = TextEditingController();
  TextEditingController noHpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController fictController = TextEditingController();
  TextEditingController ibuController = TextEditingController();
  TextEditingController agamaController = TextEditingController();

  // Image picker
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  // Load the data

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = pickedFile;
      notifyListeners();
    }
  }

  void saveProfileData() {
    // Retrieve data from controllers
    String nama = namaController.text;
    String npm = npmController.text;
    String noHp = noHpController.text;
    String email = emailController.text;
    String alamat = alamatController.text;
    String fict = fictController.text;

    // Implement your logic to save the data
    // You can use SharedPreferences, a database, or a server API here
    print('Saving profile data...');
    print('Nama: $nama');
    print('NPM: $npm');
    print('No Hp: $noHp');
    print('Email: $email');
    print('Alamat: $alamat');
    print('FICT/Informatika: $fict');

    // Add any other saving/persistence logic here
  }

  @override
  void dispose() {
    namaController.dispose();
    npmController.dispose();
    noHpController.dispose();
    emailController.dispose();
    alamatController.dispose();
    fictController.dispose();
    super.dispose();
  }
}
