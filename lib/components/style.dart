import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData themeData = ThemeData(
  unselectedWidgetColor: Colors.grey[200],
  fontFamily: 'Poppins',
  accentColor: Colors.white,
  tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: Colors.grey),
  appBarTheme:
      AppBarTheme(iconTheme: IconThemeData(size: 13, color: Colors.black)),
  scaffoldBackgroundColor: darkBg,
  dividerColor: backgroundColor,
  primaryColor: Color(0xff0FC874),
  backgroundColor: darkBg,
  textTheme: TextTheme(
      button: TextStyle(color: Colors.white),
      bodyText1: TextStyle(
          color: Color(0xff4d4d4d), fontSize: 17, fontWeight: FontWeight.w500),
      bodyText2: TextStyle(
          color: Color(0xffa3bccf), fontSize: 14, fontWeight: FontWeight.w500),
      headline5: TextStyle(color: Colors.white, fontSize: 20),
      subtitle1: TextStyle(color: Colors.white)),
);
