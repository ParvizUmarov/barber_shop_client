
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../theme/theme_provider.dart';

class CustomerSettingsModel extends ChangeNotifier{

  void changeThemeMode(BuildContext context){
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

     isDarkMode(BuildContext context)  {
     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
     return isDarkMode;

  }




}