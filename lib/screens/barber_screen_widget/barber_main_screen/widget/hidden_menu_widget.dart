import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import '../../factories/barber_screen_factories.dart';


class BarberHiddenMenuWidget extends StatefulWidget {
  const BarberHiddenMenuWidget({super.key});

  @override
  State<BarberHiddenMenuWidget> createState() => _BarberHiddenMenuWidgetState();
}

class _BarberHiddenMenuWidgetState extends State<BarberHiddenMenuWidget> {
  List<ScreenHiddenDrawer> _pages = [];
  final _screenFactory = BarberScreenFactory.instance;

  final baseStyle = TextStyle(
    fontSize: 13,
  );

  final selectedStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600
  );

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Главная',
              baseStyle: baseStyle,
              selectedStyle: selectedStyle
          ),
          _screenFactory.makeMainScreen()
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Настройки',
              baseStyle: baseStyle,
              selectedStyle: selectedStyle
          ),
          _screenFactory.makeSettingScreen()
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Профиль',
              baseStyle: baseStyle,
              selectedStyle: selectedStyle
          ),
          _screenFactory.makeProfileScreen()
      ),


    ];
  }


  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: Theme.of(context).colorScheme.background,

    );
  }
}

