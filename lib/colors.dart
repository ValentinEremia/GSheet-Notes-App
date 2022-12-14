import 'package:flutter/material.dart';

var purple = Color(0xFF5B41BC);
const myTeal = Color(0xFf4cbca1);

Map<int, Color> customPurple = {
  50: Color(0xFF483394),
  100: Color.fromARGB(255, 69, 55, 118),
  200: Color.fromARGB(255, 74, 60, 126),
  300: Color.fromARGB(255, 75, 60, 148),
  400: Color.fromARGB(255, 74, 61, 175),
  500: Color.fromARGB(255, 74, 61, 175),
  600: Color.fromARGB(255, 90, 76, 197),
  700: Color.fromARGB(255, 96, 81, 205),
  800: Color.fromARGB(255, 105, 91, 212),
  900: Color.fromARGB(255, 111, 96, 228),
};

MaterialColor colorCustom = MaterialColor(
  0xFF5B41BC,
  customPurple,
);
