import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFE1A8A8);
  static const Color background = primary;
  static const Color light  = Color(0xEEEDE8D0);

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
      primary: primary,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle( color: Color(0xFF1E1E1E) ),
      bodyLarge: TextStyle( color: Color(0xFF1E1E1E) ),
      titleLarge: TextStyle( color: Color(0xFF1E1E1E) ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: primary.withOpacity(0.35),
      labelStyle: const TextStyle(color: Color(0xFF1E1E1E)),
      hintStyle: const TextStyle(color: Color(0xFF1E1E1E)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size.fromHeight(48),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xB30A0A0A)),
    ),
  );
}
