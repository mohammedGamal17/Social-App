import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'colors.dart';

class ThemeService {
  final ThemeData light = ThemeData(
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: lightBackground,
      actionsIconTheme: IconThemeData(
        color: iconColor,
        size: 20.0,
      ),
      titleTextStyle: TextStyle(
          color: textColor, fontSize: 18.0, fontWeight: FontWeight.bold),
      titleSpacing: 10.0,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: iconColor,
        size: 20.0,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0.0,
      backgroundColor: lightBackground,
      selectedIconTheme: IconThemeData(
        color: selectedIconLightColor,
        size: 24.0,
      ),
      showUnselectedLabels: false,
      unselectedIconTheme: IconThemeData(
        size: 16.0,
        color: unselectedIconLightColor,
      ),
      selectedItemColor: selectedIconLightColor,
      selectedLabelStyle: const TextStyle(fontSize: 11.0),
    ),
    textTheme: TextTheme(
      headline5: TextStyle(
        color: textColor,
        fontFamily: 'RobotoCondensed',
      ),
      bodyText1: TextStyle(
        color: textColor,
        fontFamily: 'RobotoCondensed',
      ),
      bodyText2: TextStyle(
        color: textColor,
        fontFamily: 'RobotoCondensed',
      ),
      caption: TextStyle(
        color: textColor,
        fontFamily: 'RobotoCondensed',
      ),
      overline: TextStyle(
        color: textColor,
        fontFamily: 'RobotoCondensed',
      ),
    ),
    iconTheme: IconThemeData(
      color: iconColor,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      circularTrackColor: lightBackground,
      color: darkBackground,
    ),
  );
  final ThemeData dark = ThemeData(
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground,
      actionsIconTheme: IconThemeData(
        color: iconColor,
        size: 20.0,
      ),
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      titleSpacing: 10.0,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: iconColor,
        size: 20.0,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkBackground,
      selectedIconTheme: IconThemeData(
        color: selectedIconDarkColor,
        size: 20.0,
      ),
      showUnselectedLabels: false,
      unselectedIconTheme: IconThemeData(
        size: 16.0,
        color: unselectedIconDarkColor,
      ),
      selectedItemColor: selectedIconDarkColor,
      selectedLabelStyle: const TextStyle(fontSize: 11.0),
      elevation: 0.0,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      circularTrackColor: darkBackground,
      color: lightBackground,
    ),
    textTheme: TextTheme(
      headline5: TextStyle(
        color: textColor,
        fontFamily: 'RobotoCondensed',
      ),
      bodyText1: TextStyle(
        color: textColor,
        fontFamily: 'RobotoCondensed',
      ),
      bodyText2: TextStyle(
        color: textColor,
        fontFamily: 'RobotoCondensed',
      ),
      caption: TextStyle(
        color: textColor,
        fontFamily: 'RobotoCondensed',
      ),
      overline: TextStyle(
        color: HexColor('FFFFFF'),
        backgroundColor: HexColor('0077B6'),
        fontFamily: 'RobotoCondensed',
      ),
    ),
    iconTheme: IconThemeData(
      color: iconColor,
    ),
  );

  final _getStorage = GetStorage();
  final _darkThemeKey = 'isDarkTheme';

  void saveThemeData(bool isDarkMode) {
    _getStorage.write(_darkThemeKey, isDarkMode);
  }

  bool isSavedDarkMode() {
    return _getStorage.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }
}
