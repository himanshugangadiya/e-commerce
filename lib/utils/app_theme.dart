import 'package:e_commerce_app/utils/height_width.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: AppColor.white,
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(
      color: AppColor.black,
    ),
    titleTextStyle: GoogleFonts.inter(
      color: AppColor.black,
      fontSize: 18.5,
      fontWeight: FontWeight.w600,
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 22,
    ),

    displayMedium: GoogleFonts.inter(
      fontSize: 19,
      fontWeight: FontWeight.w600,
    ),

    /// default body text theme
    bodyMedium: GoogleFonts.inter(
      fontSize: 17,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 16,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ).apply(
    bodyColor: AppColor.black,
    displayColor: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: MaterialStateProperty.all(AppColor.purple),
      fixedSize: MaterialStateProperty.all(Size(double.infinity, H(0.06))),
      elevation: MaterialStateProperty.all(0.0),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    suffixIconColor: AppColor.green,
    labelStyle: TextStyle(
      color: AppColor.grey,
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
    ),
    contentPadding: EdgeInsets.all(2),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: AppColor.red,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: AppColor.black,
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: AppColor.grey,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: AppColor.grey,
      ),
    ),
  ),
);
