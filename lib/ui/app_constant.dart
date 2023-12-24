import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static TextStyle textNormal = GoogleFonts.k2d(
    fontWeight: FontWeight.bold,
  );
  static TextStyle textHeader = GoogleFonts.k2d(
    fontWeight: FontWeight.bold,
    fontSize: 35,
    color: Colors.black,
  );
  static TextStyle textHeaderV2 = GoogleFonts.k2d(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textError = GoogleFonts.k2d(
    fontSize: 15,
    color: Colors.red,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textSize18 = GoogleFonts.k2d(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textLink = GoogleFonts.k2d(
    fontSize: 18,
    color: Colors.blue,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textButton = GoogleFonts.k2d(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textBody = GoogleFonts.k2d(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle textBodyFocus = GoogleFonts.k2d(
    fontSize: 25,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textFill = GoogleFonts.k2d(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textFillShow = GoogleFonts.k2d(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textWhite = GoogleFonts.k2d(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textWhiteBold = GoogleFonts.k2d(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textCourse = GoogleFonts.k2d(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textCourseBold = GoogleFonts.k2d(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static LinearGradient colorGradient = const LinearGradient(colors: [
    Colors.blue,
    Colors.blue,
  ]);
  static Color themeColor = Colors.blue;
  static Color backgroundColor = const Color.fromRGBO(238, 238, 238, 1);

  static bool isDate(String date) {
    try {
      var inputFormat = DateFormat('yyyy/dd/MM');
      // ignore: unused_local_variable
      var dates = inputFormat.parseStrict(date);
      return true;
    } catch (e) {
      return false;
    }
  }
}
