import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lupa_pw_controller.dart';

class LupaPwView extends GetView<LupaPwController> {
  const LupaPwView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LupaPwView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LupaPwView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // 🔹 Background Image
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/bgloginfix.png',
//               fit: BoxFit.cover,
//             ),
//           ),

//           // 🔹 Konten
//           SafeArea(
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // 🔹 Form Card (Dinaikkan dengan Transform)
//                       Transform.translate(
//                         offset: const Offset(0, -50), // Geser ke atas
//                         child: Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                             color: Colors.white.withOpacity(0.9),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 4),
//                               )
//                             ],
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               // 🔹 Judul
//                               Text(
//                                 'Reset Password',
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.balooBhai2(
//                                   color: Colors.black,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),

//                               // 🔹 Input Email
//                               TextFormField(
//                                 controller: controller.emailController,
//                                 decoration: InputDecoration(
//                                   labelText: 'Masukan Email',
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 20),

//                               // 🔹 Tombol Kirim Kode OTP
//                               SizedBox(
//                                 width: double.infinity,
//                                 height: 50,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.redAccent,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                   ),
//                                   onPressed: () {
//                                     Get.snackbar("Info", "Kode OTP telah dikirim ke email Anda",
//                                         backgroundColor: Colors.green,
//                                         colorText: Colors.white);
//                                   },
//                                   child: Text(
//                                     "Kirim kode OTP",
//                                     style: GoogleFonts.balooBhai2(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
}
