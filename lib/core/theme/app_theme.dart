import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryDark = Color(0xFF2B2D42);
  static const Color primaryLight = Color(0xFFE0E7FF);
  
  static const Color accent = Color(0xFF6366F1); // Indigo
  static const Color accentLight = Color(0xFF818CF8);
  
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryDark,
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: Brightness.light,
        surface: const Color(0xFFFFFFFF),
        error: error,
      ),
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: const Color(0xFF1F2937),
        displayColor: primaryDark,
      ).copyWith(
        displayLarge: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: primaryDark),
        headlineMedium: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w600, color: primaryDark),
        titleMedium: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xFF1F2937)),
        bodyMedium: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.normal, color: const Color(0xFF4B5563)),
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: accent, width: 2)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryLight,
      scaffoldBackgroundColor: const Color(0xFF111827),
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: Brightness.dark,
        surface: const Color(0xFF1F2937),
        error: const Color(0xFFF87171),
      ),
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: const Color(0xFFF9FAFB),
        displayColor: const Color(0xFFF9FAFB),
      ).copyWith(
        displayLarge: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        headlineMedium: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        titleMedium: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xFFF3F4F6)),
        bodyMedium: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.normal, color: const Color(0xFFD1D5DB)),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: const Color(0xFF1F2937),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF374151),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: accentLight, width: 2)),
      ),
       floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: Colors.white,
         elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
