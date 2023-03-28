import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      checkboxTheme: CheckboxThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(8))),
      buttonTheme: ButtonThemeData(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20))),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: Colors.grey,
        ),
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.grey,
        )),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
        )),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
        )),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: Colors.transparent,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black26,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ));

  static final darkTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
