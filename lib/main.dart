import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(SiHematApp());
}

class SiHematApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiHeman - Vehicle Tracking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
      ),
      home: SplashScreen(),
    );
  }
}

// screens/splash_screen.dart
