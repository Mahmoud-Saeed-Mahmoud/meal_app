import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;

  var tm = ThemeMode.system;
  String themeText = 's';

  // ? String = themText = 'System';

  _getThemText(ThemeMode tm) {
    if (tm == ThemeMode.dark)
      themeText = 'd';
    else if (tm == ThemeMode.light)
      themeText = 'l';
    else if (tm == ThemeMode.system) themeText = 's';
  }

  onChanged(newColor, n) async {
    n == 1
        ? primaryColor = _setMaterialColor(newColor.hashCode)
        : accentColor = _setMaterialColor(newColor.hashCode);
    notifyListeners();
  }

  MaterialColor _setMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: Color(0xFFFCE4EC),
        100: Color(0xFFF8BBD0),
        200: Color(0xFFF48FB1),
        300: Color(0xFFF06292),
        400: Color(0xFFEC407A),
        500: Color(colorVal),
        600: Color(0xFFD81B60),
        700: Color(0xFFC2185B),
        800: Color(0xFFAD1457),
        900: Color(0xFF880E4F),
      },
    );
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemText(tm);
    notifyListeners();
  }
}
