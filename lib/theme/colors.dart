import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF6B4C9A);
  static const Color primaryLight = Color(0xFFAD7BE9);
  static const Color primaryDark = Color(0xFF4A2F7A);

  // Neutral
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Dark Mode
  static const Color darkBg = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFE0E0E0);

  // Stall Colors
  static const Color stallYakiNiku = Color(0xFFEF5350); // 焼肉 - Red
  static const Color stallVeggie = Color(0xFF66BB6A); // 野菜 - Green
  static const Color stallDessert = Color(0xFFEC407A); // デザート - Pink
  static const Color stallFruit = Color(0xFFFFCA28); // 果物 - Amber
  static const Color stallNoodle = Color(0xFF8D6E63); // 麺類 - Brown
  static const Color stallDrink = Color(0xFF29B6F6); // 飲料 - Blue

  // Semantic
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF29B6F6);

  // Gradient
  static const LinearGradient nightMarketGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2C1B4F),
      Color(0xFF4A2F7A),
    ],
  );
}
