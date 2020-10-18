import 'package:flutter/material.dart';

class ThemeUtil {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Color(0xFFf7fafc),
      buttonColor: Color(0xFF2196f3),
      accentColor: Color(0xFF2196f3),
      cardColor: Color(0xFF1b7cca),
      bottomAppBarColor: Colors.white,
      primaryColorDark: Color(0xFF495057),
      cursorColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF2196f3)
        ),
        elevation: 6.0
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Color(0xFF495057),
          fontSize: 22.0,
          fontWeight: FontWeight.normal
          // fontWeight: FontWeight.w300
        ),
        headline2: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Color(0xFF495057)
        ),
        bodyText1: TextStyle(
          fontSize: 16.0,
          color: Color(0xFF495057),
          fontWeight: FontWeight.w300
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0
          )
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          )
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        highlightElevation: 0
      )
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      buttonColor: Colors.white,
      accentColor: Colors.white12,
      cardColor: Colors.white12,
      primaryColorDark: Colors.white,
      cursorColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white12,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        elevation: 0.0
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
          fontWeight: FontWeight.normal
          // fontWeight: FontWeight.w300
        ),
        headline2: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.white
        ),
        bodyText1: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w300
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0
          )
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          )
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        elevation: 0,
        highlightElevation: 0
      )
    );
  }
}