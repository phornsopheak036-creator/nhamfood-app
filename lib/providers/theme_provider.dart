import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isLoading = true;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;
  bool get isLoading => _isLoading;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final isDark = prefs.getBool('isDark') ?? false;

    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    _isLoading = false;

    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDark', isDark);

    notifyListeners();
  }

  

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.light,

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFFF6B35),

        brightness: Brightness.light,

        primary: const Color(0xFFFF6B35),

        secondary: const Color(0xFF2D9CDB),

        tertiary: const Color(0xFF27AE60),

        surface: const Color(0xFFF8F4F0),
      ),

      scaffoldBackgroundColor: const Color(0xFFF8F4F0),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,

        foregroundColor: Color(0xFF1A1A2E),

        elevation: 0,

        scrolledUnderElevation: 0,

        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        color: Colors.white,

        elevation: 0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,

        selectedItemColor: Color(0xFFFF6B35),

        unselectedItemColor: Color(0xFF9E9E9E),

        type: BottomNavigationBarType.fixed,

        elevation: 0,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: const BorderSide(
            color: Color(0xFFFF6B35),

            width: 1.5,
          ),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,

          vertical: 16,
        ),
      ),

      fontFamily: 'SF Pro Display',
    );
  }


  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.dark,

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFFF6B35),

        brightness: Brightness.dark,

        primary: const Color(0xFFFF8C5A),

        secondary: const Color(0xFF56CCF2),

        tertiary: const Color(0xFF6FCF97),

        surface: const Color(0xFF0D0D1A),
      ),

      scaffoldBackgroundColor: const Color(0xFF0D0D1A),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E2E),

        foregroundColor: Colors.white,

        elevation: 0,

        scrolledUnderElevation: 0,

        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E2E),

        elevation: 0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E2E),

        selectedItemColor: Color(0xFFFF8C5A),

        unselectedItemColor: Color(0xFF6B6B8A),

        type: BottomNavigationBarType.fixed,

        elevation: 0,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,

        fillColor: const Color(0xFF1E1E2E),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: const BorderSide(
            color: Color(0xFFFF8C5A),

            width: 1.5,
          ),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,

          vertical: 16,
        ),

        hintStyle: const TextStyle(
          color: Color(0xFF6B6B8A),
        ),
      ),

      fontFamily: 'SF Pro Display',
    );
  }
}