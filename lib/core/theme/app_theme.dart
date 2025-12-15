import 'package:flutter/material.dart';

class AppTheme {
  static const Color officialColor = Color.fromARGB(255, 43, 95, 86);

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

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: effectiveColorScheme,
    );
  }
}

class CustomColorOption {
  final String name;
  final Color color;

  const CustomColorOption({required this.name, required this.color});
}
