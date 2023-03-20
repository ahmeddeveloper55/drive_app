import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle txtstyle(double Fontsize, Color color, FontWeight weight) {
  return GoogleFonts.adamina(
      fontSize: Fontsize, color: color, fontWeight: weight);
}

Color txtColor = const Color(0xf344c4f);

final darkTheme = ThemeData(
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    brightness: Brightness.dark,
    titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  backgroundColor: const Color(0xFF212121),
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primaryColor: Colors.white60,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    titleTextStyle: TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black54),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.bold,
      ),
    ),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  backgroundColor: const Color(0xFFE5E5E5),
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);
