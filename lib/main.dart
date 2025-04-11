// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/theme/theme_provider.dart';
import 'package:portfolio/screens/home_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Alex Morgan | Portfolio',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: getThemeData(false),
          darkTheme: getThemeData(true),
          home: const HomeScreen(),
        );
      },
    );
  }

  ThemeData getThemeData(bool isDarkMode) {
    final baseTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();

    final colorScheme = isDarkMode
        ? const ColorScheme.dark(
      primary: Color(0xFF6E44FF),
      secondary: Color(0xFF58E6D9),
      tertiary: Color(0xFFFF7DDB),
      background: Color(0xFF121212),
      surface: Color(0xFF1E1E1E),
      onBackground: Color(0xFFEEEEEE),
      onSurface: Color(0xFFE0E0E0),
    )
        : const ColorScheme.light(
      primary: Color(0xFF6E44FF),
      secondary: Color(0xFF58E6D9),
      tertiary: Color(0xFFFF7DDB),
      background: Color(0xFFF8F9FF),
      surface: Color(0xFFFFFFFF),
      onBackground: Color(0xFF212121),
      onSurface: Color(0xFF424242),
    );

    return baseTheme.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.background,
      textTheme: GoogleFonts.rubikTextTheme(baseTheme.textTheme).apply(
        bodyColor: colorScheme.onBackground,
        displayColor: colorScheme.onBackground,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.rubik(
          color: colorScheme.onBackground,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.rubik(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.rubik(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: GoogleFonts.rubik(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}