import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppThemes {
  AppThemes._();

  static ThemeData lightMode = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: lightTextTheme,
    cardColor: AppColors.white,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.black,
      constraints: BoxConstraints(
        minHeight: 20,
        minWidth: 20,
        maxHeight: 30,
        maxWidth: 30,
      ),

    ),
    dividerColor: AppColors.black,
    cardTheme: CardThemeData(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 1,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor:  AppColors.lightBackground,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      actionsIconTheme:  IconThemeData(
        color: AppColors.black,
        size: 24,
      ),
      elevation: 0,
      foregroundColor: AppColors.black,
      iconTheme: IconThemeData(
        color: AppColors.black,
        size: 24,
      ),

    ),
    iconTheme: const IconThemeData(
      color: AppColors.black,
      size: 24,
    ),
    chipTheme: const ChipThemeData(
      backgroundColor:  AppColors.lightBackground,
      elevation: 0,

    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.black,
        iconSize: 24,
      ),
    ),
    outlinedButtonTheme :  OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(

          side: const BorderSide(
            color: AppColors.black,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: lightTextTheme.displaySmall
      ),
    ),
    badgeTheme: BadgeThemeData(
      backgroundColor: AppColors.black,
      textStyle: lightTextTheme.displaySmall!.copyWith(fontSize: 10),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lightBackground,
      onSurface: AppColors.white,
      primary: AppColors.orange,
    ),

  );

  static ThemeData darkMode = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkBackground,
    drawerTheme: const DrawerThemeData(
      backgroundColor:  AppColors.darkBackground,
    ),
    textTheme: darkTextTheme,
    cardColor: AppColors.darkBackground,
    dividerColor: AppColors.white,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.white,

        constraints: BoxConstraints(
          minHeight: 20,
          minWidth: 20,
          maxHeight: 30,
          maxWidth: 30,
        )
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 1,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      actionsIconTheme:  IconThemeData(
        color: AppColors.white,
        size: 24,
      ),
      elevation: 0,
      foregroundColor: AppColors.white,
      iconTheme: IconThemeData(
        color: AppColors.white,
        size: 24,
      ),

    ),
    chipTheme: const ChipThemeData(
      backgroundColor:  AppColors.darkBackground,
      elevation: 0,

    ),
    iconTheme: const IconThemeData(
      color: AppColors.white,
      size: 24,
    ),
    badgeTheme: BadgeThemeData(
      backgroundColor: AppColors.white,
      textStyle: darkTextTheme.displaySmall!.copyWith(fontSize: 10),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.white,
        iconSize: 24,
      ),
    ),
    outlinedButtonTheme :  OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.white,
          side: const BorderSide(
            color: AppColors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: darkTextTheme.displaySmall
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkBackground,
      onSurface: AppColors.white,
      primary: AppColors.orange,
    ),
  );

  static const TextTheme lightTextTheme =  TextTheme(
    displayLarge: TextStyle(fontSize: 24, color: AppColors.black,fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 20, color: AppColors.black,fontWeight: FontWeight.w500),
    displaySmall: TextStyle(fontSize: 18, color: AppColors.black,fontWeight: FontWeight.w400),
  );
  static const TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 24, color: AppColors.white,fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 20, color: AppColors.white,fontWeight: FontWeight.w500),
    displaySmall: TextStyle(fontSize: 18,color: AppColors.white, fontWeight: FontWeight.w400),
  );
}


void setSystemUIOverlayStyle() {
  final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent for edge-to-edge
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness:
      brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness:
      brightness == Brightness.dark ? Brightness.light : Brightness.dark,
    ),
  );
}