import 'package:flutter/material.dart';
import 'package:ui_design_demo/screens/login/login.dart';
import 'package:ui_design_demo/screens/map/map_screen.dart';
import 'package:ui_design_demo/screens/map/top_search_section.dart';
import 'package:ui_design_demo/screens/otp/otp.dart';

void main() {
  const MaterialColor kPrimaryColor = const MaterialColor(
    0xFF49C1BD,
    const <int, Color>{
      50: const Color(0xFF49C1BD),
      100: const Color(0xFF49C1BD),
      200: const Color(0xFF49C1BD),
      300: const Color(0xFF49C1BD),
      400: const Color(0xFF49C1BD),
      500: const Color(0xFF49C1BD),
      600: const Color(0xFF49C1BD),
      700: const Color(0xFF49C1BD),
      800: const Color(0xFF49C1BD),
      900: const Color(0xFF49C1BD),
    },
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kPrimaryColor
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/otpscreen': (context) => OtpScreen(),
        '/mapscreen': (context) => MapScreen(),
        'topsearchsection': (context) => TopSearchSection()
      },
));
}