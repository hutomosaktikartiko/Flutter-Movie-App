import 'package:flutter/material.dart';

class AppStyle {
  static Color bg = Color(0xff0B1124);
  static Color bg2 = Color(0xff132555);
  static Color ambr = Color(0xffE59F2B);
  static Color brown = Color(0xff4f3444);
  static Color blue = Color(0xff1750C4);
  static Color orange = Color(0xffC23227);
  static Color skyBlue = Color(0xff5D9DD6);
  static Color ilver = Color(0xffC0CADB);

  static TextStyle title = TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
  static TextStyle subtitleMain = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static TextStyle titleMovies = TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle subtitleMovies = TextStyle(color: AppStyle.skyBlue, fontSize: 13);

  static TextStyle titleDetailMovie = TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white);

  static EdgeInsets pv10 = EdgeInsets.symmetric(vertical: 10.0);
}
