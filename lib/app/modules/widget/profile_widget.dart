import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../profile/controllers/profile_controller.dart';

class ProfileCardWidget extends GetView<ProfileController> {
  const ProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Lebar mengikuti layar
      margin: const EdgeInsets.only(bottom: 15, top: 15, left: 50, right: 50),
      padding: const EdgeInsets.all(2), // Padding bisa diatur sesuai keinginan
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Gambar Profil
          Container(
            width: 120, // Sesuaikan dengan kebutuhan
            height: 160, // Sesuaikan tinggi
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/adhi.png"),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          const SizedBox(width: 0), // Jarak antara gambar dan teks

          // Kolom Informasi Profil
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo kecil di atas
                Padding(
                  padding: const EdgeInsets.only(
                      right: 15), // Menambahkan padding kiri
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/images/HUI_logo.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 15), // Jarak antara logo dan teks

                // Informasi Profil
                _buildProfileRow("Nama", "Wendi Nugraha N"),
                _buildProfileRow("NPM", "4337855201230105"),
                _buildProfileRow("Fakultas", "Informatika"),
                _buildProfileRow("Valid", "2023 - 2027"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat baris informasi profil
  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Row(
        children: [
          SizedBox(
            // Tambahkan SizedBox untuk label
            width: 50, // Atur lebar label
            child: Text(
              "$label",
              style: const TextStyle(fontSize: 11),
            ),
          ),
          const Text(
            " : ",
            style: TextStyle(fontSize: 11),
          ),
          Expanded(
            // Tambahkan Expanded untuk nilai
            child: Text(
              value,
              style: const TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileContentWidget extends GetView<ProfileController> {
  const ProfileContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildTextField('Nama', controller.namaController),
          _buildTextField('NPM', controller.npmController),
          _buildTextField('Fakultas', controller.fictController),
          _buildTextField('Email', controller.emailController),
          _buildTextField('Nama ibu kandung', controller.ibuController),
          _buildTextField('Agama', controller.agamaController),
          _buildTextField('Alamat', controller.alamatController),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// ✅ Input Field
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: label,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileButtonWidget extends GetView<ProfileController> {
  const ProfileButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          _buildUploadPhotoButton(),
          const SizedBox(height: 10),
          _buildEditSaveButtons(),
        ],
      ),
    );
  }

  Widget _buildUploadPhotoButton() {
    return GestureDetector(
      onTap: () {
        // Handle image upload logic here
      },
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, color: Colors.red),
            SizedBox(width: 5),
            Text(
              'Upload foto',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditSaveButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildButton("Edit", Colors.black),
        _buildButton("Simpan", Colors.red),
      ],
    );
  }

  Widget _buildButton(String title, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
