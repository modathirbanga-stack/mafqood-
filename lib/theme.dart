import 'package:flutter/material.dart';

class AppColors {
  static const navy = Color(0xFF0B1929);
  static const navy2 = Color(0xFF0F2138);
  static const navy3 = Color(0xFF162840);
  static const card = Color(0xFF1C3352);
  static const card2 = Color(0xFF1E3A5C);
  static const gold = Color(0xFFD4AF37);
  static const gold2 = Color(0xFFF0CC5A);
  static const blue = Color(0xFF1E90FF);
  static const blue2 = Color(0xFF3BAAFF);
  static const red = Color(0xFFE53935);
  static const green = Color(0xFF00C853);
  static const orange = Color(0xFFFF9100);
  static const textPrimary = Color(0xFFE8EDF5);
  static const textMuted = Color(0xFF7A94B0);
  static const textMuted2 = Color(0xFFA0B8CC);
}

class AppTheme {
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.navy,
    primaryColor: AppColors.gold,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.gold,
      secondary: AppColors.blue,
      surface: AppColors.card,
      background: AppColors.navy,
    ),
    fontFamily: 'Tajawal',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.navy,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Tajawal',
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      iconTheme: IconThemeData(color: AppColors.gold),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.card,
      selectedItemColor: AppColors.gold,
      unselectedItemColor: AppColors.textMuted,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.white.withOpacity(0.06)),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary, fontFamily: 'Tajawal'),
      bodyMedium: TextStyle(color: AppColors.textMuted2, fontFamily: 'Tajawal'),
      bodySmall: TextStyle(color: AppColors.textMuted, fontFamily: 'Tajawal'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.card,
      hintStyle: const TextStyle(color: AppColors.textMuted, fontFamily: 'Tajawal'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.gold.withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.gold.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.gold.withOpacity(0.5)),
      ),
    ),
  );
}
