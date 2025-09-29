import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Inter
  static TextStyle get inter => GoogleFonts.inter();

  static TextStyle interStyle({double size = 14, FontWeight weight = FontWeight.normal, Color? color}) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle get heading1 => interStyle(size: 24, weight: FontWeight.bold);
  static TextStyle get heading3 => interStyle(size: 20, weight: FontWeight.w700);
  static TextStyle get body1 => interStyle(size: 16);
  static TextStyle get bodyText2 => interStyle(weight: FontWeight.w400, color: const Color(0xFF636F85));

  // Figtree
  static TextStyle get figtree => GoogleFonts.figtree();

  static TextStyle figtreeStyle({double size = 24, FontWeight weight = FontWeight.normal, Color? color}) {
    return GoogleFonts.figtree(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  // Poppins
  static TextStyle get poppins => GoogleFonts.poppins();

  static TextStyle poppinsStyle({double size = 14, FontWeight weight = FontWeight.normal, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }
}
