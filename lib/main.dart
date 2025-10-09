import 'package:flutter/material.dart';
import 'package:sihemat/screens/dashboard_screen.dart';
import 'screens/splash_screen.dart';


void main() {
  runApp(const SiHematApp());
}

class SiHematApp extends StatelessWidget {
  const SiHematApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiHeman - Vehicle Tracking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const DashboardScreen(),
    );
  }
}

// screens/splash_screen.dart
