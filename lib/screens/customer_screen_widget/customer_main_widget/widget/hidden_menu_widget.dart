import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import '../../factories/customer_screen_factory.dart';


class CustomerHiddenMenuWidget extends StatefulWidget {
  const CustomerHiddenMenuWidget({super.key});

  @override
  State<CustomerHiddenMenuWidget> createState() => _CustomerHiddenMenuWidgetState();
}

class _CustomerHiddenMenuWidgetState extends State<CustomerHiddenMenuWidget> {
  List<ScreenHiddenDrawer> _pages = [];
  final _screenFactory = CustomerScreenFactory.instance;

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
              name: 'История заказов',
              baseStyle: baseStyle,
              selectedStyle: selectedStyle
          ),
          _screenFactory.makeCustomerHistoryPage()
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
