import 'package:flutter/material.dart';

ThemeData minimalistTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF6F6F6),

  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      letterSpacing: -0.5,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFE5E5E5), // Light grey input
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Large rounded corners
      ),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.black,
      minimumSize: const Size(double.infinity, 56),
      side: const BorderSide(color: Color(0xFFD1D1D1)), // Thin light border
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
);
