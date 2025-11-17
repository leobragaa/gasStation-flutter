import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFE1A8A8);
  static const Color background = Color(0xFF1E1E1E);

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF1E1E1E),
      brightness: Brightness.light,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFE1A8A8).withOpacity(0.35),
      labelStyle: const TextStyle(color: Color(0xFF1E1E1E)),
      hintStyle: const TextStyle(color: Color(0xFF1E1E1E)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size.fromHeight(48),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xB30A0A0A)),
    ),
  );
}
