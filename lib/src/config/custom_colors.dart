import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  050: const Color.fromRGBO(135, 5, 250, 0.1),
  100: const Color.fromRGBO(135, 5, 250, 0.2),
  200: const Color.fromRGBO(135, 5, 250, 0.3),
  300: const Color.fromRGBO(135, 5, 250, 0.4),
  400: const Color.fromRGBO(135, 5, 250, 0.5),
  500: const Color.fromRGBO(135, 5, 250, 0.6),
  600: const Color.fromRGBO(135, 5, 250, 0.7),
  700: const Color.fromRGBO(135, 5, 250, 0.8),
  800: const Color.fromRGBO(135, 5, 250, 0.9),
  900: const Color.fromRGBO(135, 5, 250, 1.0),
};

abstract class CustomColors {
  static Color customContrastColor = const Color.fromRGBO(250,5,135, 1.0);
  static MaterialColor customSwatchColor =
      MaterialColor(0xFF8705FA, _swatchOpacity);
}
