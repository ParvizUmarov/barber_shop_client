import 'package:barber_shop/ui/widgets/barber_screen_widget/main_screen/barber_main_screens/chat_page_widget/chat_page_widget.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/main_screen/barber_main_screens/home_page_widget/home_page_widget.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/main_screen/barber_main_screens/map_page_widget/map_page_widget.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/main_screen/barber_main_screens/orders_page_widget/orders_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../../../colors/Colors.dart';
import '../../barber_main_screens/reels_page_widget/reels_page_widget.dart';


class BarberMainScreenWidget extends StatefulWidget {
  const BarberMainScreenWidget({super.key});

  @override
  State<BarberMainScreenWidget> createState() => _BarberMainScreenWidgetState();
}

class _BarberMainScreenWidgetState extends State<BarberMainScreenWidget> {
  int _selectedIndex = 0;
  String _title = 'Главная';
  static const List<Widget> _widgetOfPages = <Widget>[
    BarberHomePage(),
    BarberOrdersPage(),
    BarberReelsPageWidget(),
    BarberChatPage(),
    BarberMapPage(),
  ];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    _title = 'Главная';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: _widgetOfPages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: GNav(
          tabBackgroundColor: AppColors.mainColor,
          activeColor: Colors.white,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          tabBorderRadius: 24,
          padding: EdgeInsets.all(10),
          color: Colors.grey,
          iconSize: 25,
          gap: 10,
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Главная',
            ),
            GButton(
              icon: Icons.event_note,
              text: 'Заказы',
            ),
            GButton(
              icon: Icons.play_circle,
              text: 'Reels',
            ),
            GButton(
              icon: Icons.chat,
              text: 'Чат',
            ),
            GButton(
              icon: Icons.location_on,
              text: 'Карта',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index){
            setState(() {
              print(_scaffoldKey);
              _selectedIndex = index;
              switch(index) {
                case 0: { _title = 'Главная'; }
                break;
                case 1: { _title = 'Заказы'; }
                break;
                case 2: { _title = 'Reels'; }
                break;
                case 3: { _title = 'Чаты'; }
                break;
                case 4: { _title = 'Карта'; }
                break;
              }
            });
          },
        ),
      ),

    );
  }
}

