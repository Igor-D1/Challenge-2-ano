import 'package:flutter/material.dart';

class AppTheme {
  // Cores do Design System Oficial
  static const Color darkNavy = Color(0xFF0B192C);      // Fundo Principal Escuro
  static const Color deepNavy = Color(0xFF0D1B2A);      // Fundo Secundário
  static const Color surfaceBlue = Color(0xFF1E3E62);   // Cards / Containers
  static const Color borderBlue = Color(0xFF415A77);    // Bordas de apoio
  static const Color cyanAccent = Color(0xFF00B4D8);    // Destaque e Interatividade
  static const Color cyanBright = Color(0xFF00E5FF);    // Brilho vibrante

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkNavy,
      primaryColor: cyanAccent,
      colorScheme: const ColorScheme.dark(
        primary: cyanAccent,
        secondary: cyanBright,
        surface: surfaceBlue,
        background: darkNavy,
        onBackground: Colors.white,
        onSurface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: deepNavy,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        iconTheme: IconThemeData(color: cyanAccent),
      ),
      cardTheme: CardThemeData(
        color: surfaceBlue,
        elevation: 4,
        shadowColor: cyanAccent.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderBlue.withValues(alpha: 0.5), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cyanAccent,
          foregroundColor: darkNavy,
          elevation: 3,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cyanAccent,
          side: const BorderSide(color: cyanAccent, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: deepNavy,
        selectedItemColor: cyanAccent,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        elevation: 12,
      ),
    );
  }
}

