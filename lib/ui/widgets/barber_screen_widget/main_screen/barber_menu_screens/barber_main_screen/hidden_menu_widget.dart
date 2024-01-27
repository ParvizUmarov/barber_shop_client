import 'package:barber_shop/ui/widgets/barber_screen_widget/factories/barber_screen_factories.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/main_screen/barber_menu_screens/barber_main_screen/barber_main_screen_widget.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/main_screen/barber_menu_screens/barber_profile_screen/barber_profile_screen.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/main_screen/barber_menu_screens/barber_settings_screen/barber_settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

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
          BarberMainScreenWidget()
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Настройки',
              baseStyle: baseStyle,
              selectedStyle: selectedStyle
          ),
          BarberSettingsWidget()
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

