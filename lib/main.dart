import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login.dart';
import 'pages/dashboard.dart'; // Import dashboard
import 'controllers/login_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
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
      },
    );
  }
}
