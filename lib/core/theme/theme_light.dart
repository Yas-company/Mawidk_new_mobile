import 'package:flutter/material.dart';

import '../data/constants/app_colors.dart';

class ThemeLight {
  static ThemeData? get theme => ThemeData(
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(AppColors.primaryColor),
      // fillColor: MaterialStateProperty.all(AppColors.whiteColor),
    ),
    listTileTheme: const ListTileThemeData(
      selectedColor:AppColors.primaryColor,
      contentPadding: EdgeInsets.zero,
    ),
        dividerColor: AppColors.grayColor200,
        brightness: Brightness.light,
        useMaterial3: true,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          primary: AppColors.primaryColor,
          secondary: AppColors.secondary,
          brightness: Brightness.light,
          onPrimaryContainer: AppColors.grayColor100,
          inversePrimary:AppColors.primaryColor
        ),

        scaffoldBackgroundColor: AppColors.background,
        cardColor: AppColors.whiteColor,
        dialogBackgroundColor: AppColors.whiteColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.whiteColor,
        ),

        appBarTheme: const AppBarTheme(
          surfaceTintColor:AppColors.background,
          backgroundColor: AppColors.background,
          iconTheme: IconThemeData(
            color: AppColors.dangerColor,
            size: 24,
          ),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            fontFamily: 'Cairo',
            color: AppColors.blackColor,
          ),
          centerTitle: false,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
            elevation: 0,
            padding: EdgeInsets.zero,
            minimumSize: const Size(80, 48),
          ),
        ),

        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.normal,
          minWidth: 88,
          height: 48,
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
          buttonColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.primaryColor,
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true, // Enable the fill color
          fillColor: AppColors.whiteColor, // Set the fill color
          border: OutlineInputBorder(
            // Optional: Customize the border
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: AppColors.dangerColor,
            ),
          ),
        ),
        fontFamily: 'Cairo',
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headlineMedium: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headlineLarge: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          titleSmall: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          bodySmall: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          bodyMedium: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          bodyLarge: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          titleMedium: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          titleLarge: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
      );
}
