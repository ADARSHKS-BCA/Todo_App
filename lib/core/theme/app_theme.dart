import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Pastel Palette
  static const Color mintGreen = Color(0xFFB9F6CA);
  static const Color babyBlue = Color(0xFFBBDEFB);
  static const Color lavender = Color(0xFFE1BEE7);
  static const Color peach = Color(0xFFFFCCBC);
  static const Color creamyWhite = Color(0xFFFDFBF7);
  static const Color darkText = Color(0xFF2D2D2D);
  static const Color lightText = Color(0xFF757575);
  static const Color primaryAccent = Color(0xFF6C63FF); // A nice purple for accents

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: creamyWhite,
      colorScheme: ColorScheme.fromSeed(
        seedColor: babyBlue,
        brightness: Brightness.light,
        surface: creamyWhite,
      ),
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: darkText,
        displayColor: darkText,
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        color: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkText, 
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
