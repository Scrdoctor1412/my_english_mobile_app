import 'package:flutter/material.dart';

class ThemePrimary {
  static const grey = Color(0xff868686);
  static const primaryBlue = Color(0xff007aff);
  static const lightBlue = Color(0xff66b2ff);
  static const darkBlue = Color(0xff004a99);

  static const primaryOrange = Color(0xffff9500);
  static const lightOrange = Color(0xffffc266);

  static const darkGrey = Color(0xff333333);

  static final ColorScheme myColorScheme = ColorScheme(
    primary: Color(0xFF007AFF), // Xanh dương chính
    primaryContainer: Color(0xFF66B2FF), // Xanh dương nhạt
    secondary: Color(0xFFFF9500), // Cam chính
    secondaryContainer: Color(0xFFFFC266), // Cam nhạt
    background: Color(0xFFFFFFFF), // Nền trắng
    surface: Color(0xFFF5F5F5), // Màu nền phụ
    onPrimary: Color(0xFFFFFFFF), // Văn bản trên nền xanh dương
    onSecondary: Color(0xFF333333), // Văn bản trên nền cam
    onBackground: Color(0xFF333333), // Văn bản trên nền trắng
    onSurface: Color(0xFF333333), // Văn bản trên nền phụ
    error: Color(0xFFB00020), // Màu lỗi
    onError: Color(0xFFFFFFFF), // Văn bản trên nền lỗi
    brightness: Brightness.light, // Giao diện sáng
  );

  static theme() {
    return ThemeData(
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
      ),
      colorScheme: myColorScheme,
      appBarTheme: AppBarTheme(
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
    );
  }
}
