import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color officialColor = Color.fromARGB(255, 43, 95, 86);

  // Semantic Colors - Use these instead of hardcoded red/green
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;

  static const List<CustomColorOption> customColors = [
    CustomColorOption(name: 'Orange', color: Colors.orange),
    CustomColorOption(name: 'Green', color: Colors.green),
    CustomColorOption(name: 'Blue', color: Colors.blue),
    CustomColorOption(name: 'Red', color: Colors.red),
    CustomColorOption(name: 'Purple', color: Colors.purple),
    CustomColorOption(name: 'Pink', color: Colors.pink),
    CustomColorOption(name: 'Teal', color: Colors.teal),
    CustomColorOption(name: 'Cyan', color: Colors.cyan),
  ];

  static ThemeData createTheme({
    required ColorScheme? colorScheme,
    required Brightness brightness,
    Color? seedColor,
  }) {
    final effectiveColorScheme =
        colorScheme ??
        ColorScheme.fromSeed(
          seedColor: seedColor ?? officialColor,
          brightness: brightness,
        );

    // Default font: Poppins. Easy to switch by changing this one line.
    // e.g. return GoogleFonts.interTextTheme(base);
    TextTheme getFontTheme(TextTheme base) {
      return GoogleFonts.poppinsTextTheme(base);
    }

    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: effectiveColorScheme,
    );

    return baseTheme.copyWith(textTheme: getFontTheme(baseTheme.textTheme));
  }
}

class CustomColorOption {
  final String name;
  final Color color;

  const CustomColorOption({required this.name, required this.color});
}
