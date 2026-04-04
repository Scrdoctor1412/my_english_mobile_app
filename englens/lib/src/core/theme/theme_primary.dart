import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemePrimary {
  ThemePrimary._();

  static const grey = Color(0xff868686);
  static const primaryBlue = Color(0xff007aff);
  static const lightBlue = Color(0xff66b2ff);
  static const darkBlue = Color(0xff004a99);

  static const primaryOrange = Color(0xffff9500);
  static const lightOrange = Color(0xffffc266);

  // static const successGreen = Color(0xff34c759);
  static const successGreen = Color(0xFF3FA86B);
  static const lightGreen = Color(0xffA0E9B3);
  static const darkGreen = Color(0xff248A3D);

  static const darkGrey = Color(0xff333333);

  static final ColorScheme myColorScheme = const ColorScheme(
    primary: Color(0xFF007AFF), // Xanh dương chính
    primaryContainer: Color(0xFF66B2FF), // Xanh dương nhạt
    secondary: Color(0xFFFF9500), // Cam chính
    secondaryContainer: Color(0xFFFFC266), // Cam nhạt
    background: Color(0xFFFBFAFF), // Nền trắng ngà (Light)
    surface: Color(0xFFFFFFFF), // Màu nền phụ (Light)
    onPrimary: Color(0xFFFFFFFF), // Văn bản trên nền xanh dương
    onSecondary: Color(0xFF333333), // Văn bản trên nền cam
    onBackground: Color(0xFF333333), // Văn bản trên nền trắng
    onSurface: Color(0xFF333333), // Văn bản trên nền phụ
    error: Color(0xFFB00020), // Màu lỗi
    onError: Color(0xFFFFFFFF), // Văn bản trên nền lỗi
    brightness: Brightness.light, // Giao diện sáng
  );

  static final ColorScheme darkColorScheme = const ColorScheme(
    primary: Color(0xFF7B61FF), // Tím Englens
    primaryContainer: Color(0xFF5A45D1), 
    secondary: Color(0xFFFF9500), 
    secondaryContainer: Color(0xFFCC7700),
    background: Color(0xFF121214), // Nền đen sâu (Dark mode)
    surface: Color(0xFF1E1C24), // Màu nền phụ (Dark mode - Container)
    onPrimary: Color(0xFFFFFFFF), 
    onSecondary: Color(0xFF121214), 
    onBackground: Color(0xFFE0E0E0), // Text tĩnh trên nền (Dark)
    onSurface: Color(0xFFE0E0E0), 
    error: Color(0xFFCF6679), 
    onError: Color(0xFF121214), 
    brightness: Brightness.dark, 
  );

  static theme() {
    return ThemeData(
      textTheme: GoogleFonts.beVietnamProTextTheme(),
      colorScheme: myColorScheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFFFBFAFF),
    );
  }

  static darkTheme() {
    return ThemeData(
      textTheme: GoogleFonts.beVietnamProTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: const Color(0xFFE0E0E0),
        displayColor: const Color(0xFFE0E0E0),
      ),
      colorScheme: darkColorScheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121214),
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF7B61FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFF121214),
      cardColor: const Color(0xFF1E1C24),
    );
  }
}
