
import 'package:barber_shop/ui/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData? _currentTheme;

  ThemeData? get currentTheme => _currentTheme;

  bool get getThemeMode => _currentTheme == darkMode;

  bool? _isDarkMode;
  
  bool? get getTheme => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
  }

  ThemeProvider({required bool? isDarkMode}) {
    _isDarkMode = isDarkMode;
    isDarkMode == true
        ? _currentTheme = darkMode
        : _currentTheme = lightMode;
  }

  Future<void> toggleTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(_currentTheme == darkMode){
      _currentTheme = lightMode;
      prefs.setBool('isDarkMode', false);
    }else {
      _currentTheme = darkMode;
      prefs.setBool('isDarkMode', true);
    }
    notifyListeners();
  }
}