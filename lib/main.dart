import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login.dart';
import 'pages/dashboard.dart'; // Import dashboard
import 'controllers/login_controller.dart';
import 'controllers/profile_controller.dart';
import 'pages/profile.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => ProfileController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      initialRoute: '/login', // Langsung ke halaman login
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => Dashboard(),
        '/profile': (context) => ProfileWidget(),
      },
    );
  }
}
