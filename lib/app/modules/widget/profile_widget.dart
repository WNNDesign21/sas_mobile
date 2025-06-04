import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../profile/controllers/profile_controller.dart'; // Pastikan path ini benar

// Widget untuk Tombol Simpan dan Upload Foto
class SaveButton extends GetView<ProfileController> {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement save profile logic here
        // Misalnya, jika ada field yang bisa diedit dan perlu disimpan:
        // controller.saveProfileChanges(); 
        Get.snackbar("Simpan", "Tombol Simpan Ditekan (Logika belum diimplementasikan)", snackPosition: SnackPosition.BOTTOM);
      },
      child: SizedBox(
        width: 129,
        height: 95,
        child: Stack(
          children: [
            // Save Button Background
            Positioned(
              top: 53,
              left: 0,
              child: Container(
                width: 129,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27),
                  gradient: const LinearGradient(
                    begin: Alignment(6.123234262925839e-17, 1),
                    end: Alignment(-1, 6.123234262925839e-17),
                    colors: [
                      Color.fromRGBO(255, 45, 28, 1),
                      Color.fromRGBO(205, 0, 0, 1),
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Baloo Bhai',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),

            // Upload Photo Button
            Positioned(
              top: 0,
              left: 11,
              child: Obx( // Dibungkus Obx untuk menampilkan loading indicator
                () => controller.isUploading.value
                    ? Container( 
                        width: 107,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration( // Styling agar mirip tombol
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.white,
                           border: Border.all(
                            color: const Color.fromRGBO(133, 127, 127, 1),
                            width: 2,
                          ),
                        ),
                        child: const SizedBox(
                          width: 20, 
                          height: 20, 
                          child: CircularProgressIndicator(
                            strokeWidth: 2, 
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () => controller.pickAndUploadImage(), // Panggil metode dari controller
                        child: Container(
                          width: 107,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromRGBO(133, 127, 127, 1),
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/Uploadtocloud.png', // Pastikan asset ini ada
                                width: 30,
                                height: 24,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  'Upload foto',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Baloo 2',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
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

// Widget Kartu Profil
class ProfileCard extends GetView<ProfileController> {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengakses controller karena ini adalah GetView<ProfileController>
    // final ProfileController controller = Get.find<ProfileController>(); // Tidak perlu Get.find jika sudah GetView

    return Center(
      // Wrap the entire card in a Center widget
      child: SizedBox(
        width: 275,
        height: 445, // Increase the height of the Stack
        child: Stack(
          clipBehavior: Clip.none, // Disable clipping for the Stack
          children: [
            // Background Card
            Positioned(
              top: 0,
              left: 0, // Remove left offset, as we're using Center
              child: Container(
                width: 282,
                height: 460,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.21),
                      offset: const Offset(0, 1),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),

            // Profile Info Section
            Positioned(
              top: 270 + 68 + 20, // Adjust top position
              left: 22,
              child: SizedBox(
                width: 238,
                height: 120,
                child: SingleChildScrollView(
                  // Keep SingleChildScrollView in case content overflows
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Menggunakan Obx untuk menampilkan data dinamis
                      Obx(
                        () =>
                            _buildProfileInfoRow("Name", controller.name.value),
                      ),
                      Obx(
                        () => _buildProfileInfoRow(
                          "ID Number",
                          controller.idNumber.value,
                        ),
                      ),
                      Obx(
                        () => _buildProfileInfoRow(
                          "Faculty",
                          controller.faculty.value,
                        ),
                      ),
                      Obx(
                        () => _buildProfileInfoRow(
                          "Study",
                          controller.study.value,
                        ),
                      ),
                      // Tambahkan field lain di sini jika perlu, dibungkus Obx
                    ],
                  ),
                ),
              ),
            ),

            // Profile Image
            Positioned(
              top: 100,
              left: 58,
              child: Container(
                width: 170,
                height: 235,
                decoration: BoxDecoration(
                  color: Colors.white, // Background for the image area
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(1, 1),
                      blurRadius: 21,
                    ),
                  ],
                ),
                // Observe the profile image URL from the controller
                child: Obx(() {
                  final imageUrl = controller.profileImageUrl; // Menggunakan getter
                  if (imageUrl.isNotEmpty) {
                    return Image.network(
                      imageUrl, // Ini harus menjadi URL lengkap ke gambar
                      fit: BoxFit.contain,
                      loadingBuilder: (
                        BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress,
                      ) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                          ),
                        );
                      },
                      errorBuilder: (
                        BuildContext context,
                        Object exception,
                        StackTrace? stackTrace,
                      ) {
                        // Fallback ke aset lokal jika gambar jaringan gagal dimuat
                        // Pastikan Anda memiliki gambar avatar default di aset Anda
                        print(
                          "Error loading profile image from network: $exception",
                        ); // Log error
                        return Image.asset(
                          'assets/images/default_avatar.png', // Pastikan asset ini ada
                          fit: BoxFit.contain,
                        );
                      },
                    );
                  }
                  // Tampilkan placeholder atau gambar default jika URL kosong
                  // Pastikan Anda memiliki gambar avatar default di aset Anda
                  return Image.asset(
                    'assets/images/default_avatar.png', // Pastikan asset ini ada
                    fit: BoxFit.contain,
                  );
                }),
              ),
            ),

            // Header Section
            Positioned(
              top: 0, // Adjust top position to 0
              left: 0,
              child: Container(
                width: 283,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment(1, 0),
                    end: Alignment(0, 1),
                    colors: [
                      Color.fromRGBO(90, 2, 2, 1),
                      Color.fromRGBO(192, 5, 5, 1),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(1, 0),
                      blurRadius: 4.7,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 29),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/LogoHUItext.png', // Pastikan asset ini ada
                        width: 230,
                        height: 100,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build profile info row
  Widget _buildProfileInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90, // Fixed width untuk label
            child: Text(
              label,
              style: const TextStyle(
                color: Color.fromRGBO(13, 0, 0, 0.94),
                fontFamily: 'Baloo 2',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const Text(
            ": ",
            style: TextStyle(
              color: Color.fromRGBO(13, 0, 0, 0.94),
              fontFamily: 'Baloo 2',
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color.fromRGBO(13, 0, 0, 0.94),
                fontFamily: 'Baloo 2',
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
