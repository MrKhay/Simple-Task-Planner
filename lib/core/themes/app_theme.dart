import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/core/constants/strings.dart';

class AppTheme {
  const AppTheme._();
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      onPrimary: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      shadow: Colors.grey,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    checkboxTheme: CheckboxThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(8))),
    buttonTheme: ButtonThemeData(
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20))),
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
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll(
          Colors.black,
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: Colors.black),
      labelLarge: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      onPrimary: Colors.black,
      background: Colors.black,
      onBackground: Colors.white,
      shadow: Colors.grey,
    ),
    checkboxTheme: CheckboxThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(8))),
    buttonTheme: ButtonThemeData(
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20))),
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
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll(Colors.white),
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
    ),
  );
}
