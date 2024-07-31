import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 13, 123, 182),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 245, 245, 220),
);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme().copyWith(
    bodyLarge: TextStyle(
      color: Color.fromARGB(255, 13, 123, 182),
      fontStyle: GoogleFonts.latoTextTheme().bodyLarge!.fontStyle,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontStyle: GoogleFonts.latoTextTheme().bodyLarge!.fontStyle,
    ),
    displaySmall: TextStyle(
      color: Color.fromARGB(255, 29, 171, 247),
      fontStyle: GoogleFonts.latoTextTheme().bodyLarge!.fontStyle,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 13, 123, 182),
    ),
  ),
  colorScheme: kColorScheme,
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark, // Change brightness to dark
  colorScheme: kDarkColorScheme,
  textTheme: const TextTheme().copyWith(
    bodyLarge: TextStyle(
      color: const Color.fromARGB(255, 245, 245, 220),
      fontStyle: GoogleFonts.latoTextTheme().bodyLarge!.fontStyle,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontStyle: GoogleFonts.latoTextTheme().bodyLarge!.fontStyle,
    ),
    displaySmall: TextStyle(
      color: Colors.red,
      fontStyle: GoogleFonts.latoTextTheme().bodyLarge!.fontStyle,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 245, 245, 220),
    ),
  ),
);
