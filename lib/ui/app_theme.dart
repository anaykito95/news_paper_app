import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier {
  //
  bool isDarkMode = false;

  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Lato',
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.white38,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    textTheme: new TextTheme(
      headline4: TextStyle(color: Colors.black87),
      headline6: TextStyle(color: Colors.black87),
      button: TextStyle(color: Colors.black54),
      caption: TextStyle(color: Colors.black54),
      subtitle1: TextStyle(color: Colors.black54),
      bodyText1: TextStyle(color: Colors.black54),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black87,
    fontFamily: 'Lato',
    appBarTheme: AppBarTheme(
      color: Colors.black,
      elevation: 0,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: new TextTheme(
      headline4: TextStyle(color: Colors.white70),
      headline6: TextStyle(color: Colors.white70),
      button: TextStyle(color: Colors.white60),
      caption: TextStyle(color: Colors.white54),
      subtitle1: TextStyle(color: Colors.white54),
      bodyText1: TextStyle(color: Colors.white54),
    ),
  );
}
