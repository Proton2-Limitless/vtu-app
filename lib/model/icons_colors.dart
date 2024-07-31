import 'package:flutter/material.dart';

class IconColorScheme {
  final Color airtimeColor;
  final Color dataColor;
  final Color cableColor;
  final Color electricityColor;

  const IconColorScheme({
    required this.airtimeColor,
    required this.dataColor,
    required this.cableColor,
    required this.electricityColor,
  });
}

const IconColorScheme lightIconColors = IconColorScheme(
  airtimeColor: Color.fromARGB(255, 219, 115, 229),
  dataColor: Color(0xFF64B5F6),
  cableColor: Color(0xFFFF8A65),
  electricityColor: Color(0xFF81C784),
);

const IconColorScheme darkIconColors = IconColorScheme(
  airtimeColor: Color(0xFFEF9A9A),
  dataColor: Color(0xFFBBDEFB),
  cableColor: Color(0xFFFFAB91),
  electricityColor: Color(0xFFA5D6A7),
);
