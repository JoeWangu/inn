import 'package:flutter/material.dart';

Color desaturate(Color c, double amount) {
  final hsl = HSLColor.fromColor(c);
  final hslDesat = hsl.withSaturation(
    (hsl.saturation - amount).clamp(0.0, 1.0),
  );
  return hslDesat.toColor();
}

Color lighten(Color c, [double amount = .1]) {
  final hsl = HSLColor.fromColor(c);
  return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
}

Color darken(Color c, [double amount = .1]) {
  final hsl = HSLColor.fromColor(c);
  return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
}
