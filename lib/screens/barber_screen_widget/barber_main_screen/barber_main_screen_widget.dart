
import 'dart:developer';

import 'package:barber_shop/shared/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../shared/theme/colors/Colors.dart';
import '../chat_page_widget/widget/chat_page_widget.dart';
import '../home_page_widget/home_page_widget.dart';
import '../map_page_widget/map_page_widget.dart';
import '../orders_page_widget/presentation/orders_page_widget.dart';
import '../reels_page_widget/reels_page_widget.dart';


class BarberMainScreenWidget extends StatefulWidget {
  const BarberMainScreenWidget({super.key});

  @override
  State<BarberMainScreenWidget> createState() => _BarberMainScreenWidgetState();
}

class _BarberMainScreenWidgetState extends State<BarberMainScreenWidget> {
  int _selectedIndex = 0;
  String _title = 'Главная';
  static List<Widget> _widgetOfPages = <Widget>[
    BarberHomePage(),
    makeBarberOrdersPage(),
    BarberChatPage(),
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
              icon: Icons.chat,
              text: 'Чат',
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
                case 3: { _title = 'Чаты'; }
                break;
              }
            });
          },
        ),
      ),

    );
  }
}

