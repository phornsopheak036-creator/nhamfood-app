import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFFF6B35);
  static const primaryDark = Color(0xFFFF8C5A);
  static const secondary = Color(0xFF2D9CDB);
  static const accent = Color(0xFFFFBE0B);
  static const success = Color(0xFF27AE60);
  static const error = Color(0xFFEB5757);


  static const lightBg = Color(0xFFF8F4F0);
  static const lightCard = Colors.white;
  static const lightText = Color(0xFF1A1A2E);
  static const lightSubtext = Color(0xFF6B7280);

  
  static const darkBg = Color(0xFF0D0D1A);
  static const darkCard = Color(0xFF1E1E2E);
  static const darkText = Colors.white;
  static const darkSubtext = Color(0xFF6B6B8A);
}

class AppConstants {
  static const double borderRadius = 20.0;
  static const double cardRadius = 16.0;
  static const double pagePadding = 20.0;

  static const List<String> cuisineAreas = [
    'American', 'British', 'Canadian', 'Chinese',
    'Dutch', 'Egyptian', 'French', 'Greek',
    'Indian', 'Irish', 'Italian', 'Japanese',
    'Kenyan', 'Malaysian', 'Mexican', 'Moroccan',
    'Russian', 'Spanish', 'Thai', 'Tunisian',
    'Turkish', 'Vietnamese',
  ];

  static const Map<String, String> categoryEmojis = {
    'Beef'
    'Chicken'
    'Dessert'
    'Lamb'
    'Miscellaneous'
    'Pasta'
    'Pork'
    'Seafood'
    'Side'
    'Starter'
    'Vegan'
    'Vegetarian'
    'Breakfast'
    'Goat': '',
  };
}
