import 'package:flutter/material.dart';
import 'package:yoichiyatai/theme/colors.dart';

class StallDisplayHelper {
  static const Map<String, Color> stallColors = {
    'yakiNiku': AppColors.stallYakiNiku,
    'veggie': AppColors.stallVeggie,
    'dessert': AppColors.stallDessert,
    'fruit': AppColors.stallFruit,
    'noodle': AppColors.stallNoodle,
    'drink': AppColors.stallDrink,
  };

  static const Map<String, String> stallEmojis = {
    'yakiNiku': '🍖',
    'veggie': '🥗',
    'dessert': '🍰',
    'fruit': '🍎',
    'noodle': '🍜',
    'drink': '🥤',
  };

  static Color colorFor(String stallId) =>
      stallColors[stallId] ?? AppColors.grey400;

  static String emojiFor(String stallId) => stallEmojis[stallId] ?? '❓';
}
