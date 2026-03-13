import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Light Mode
  static const Color lightBase = Color(0xFFFFFFFF);
  static const Color lightAccent = Color(0xFFF4F7F6);
  static const Color lightPrimary = Color(0xFF4F46E5); // Vibrant Indigo
  
  // Dark Mode
  static const Color darkBase = Color(0xFF121212); // Deep Charcoal
  static const Color darkAccent = Color(0xFF1E1E1E); // Slate Gray approximation
  static const Color darkPrimary = Color(0xFF6366F1); // Neon Indigo adjustment for Dark
  
  // Universal
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  
  static const List<Color> meshGradient = [
    Color(0xFF4F46E5),
    Color(0xFF818CF8),
    Color(0xFFC7D2FE),
  ];
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBase,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lightPrimary,
      surface: AppColors.lightBase,
      primary: AppColors.lightPrimary,
    ),
    textTheme: GoogleFonts.outfitTextTheme().apply(
      bodyColor: AppColors.black,
      displayColor: AppColors.black,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBase,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkPrimary,
      brightness: Brightness.dark,
      surface: AppColors.darkBase,
      primary: AppColors.darkPrimary,
    ),
    textTheme: GoogleFonts.outfitTextTheme().apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    ),
  );
}
