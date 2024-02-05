import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../theme/theme_provider.dart';

class BarberSettingsModel extends ChangeNotifier {

  void changeThemeMode(BuildContext context, bool value){
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);

  }

  isDarkMode(BuildContext context)  {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode;

  }

}