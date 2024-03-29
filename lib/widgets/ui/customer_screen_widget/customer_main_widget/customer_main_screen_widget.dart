import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../../../../localization/s.dart';
import '../../../shared/theme/colors/Colors.dart';
import '../factories/customer_screen_factory.dart';


class CustomerMainScreenWidget extends StatefulWidget {
  const CustomerMainScreenWidget({super.key});

  @override
  State<CustomerMainScreenWidget> createState() => _CustomerMainScreenWidgetState();
}

class _CustomerMainScreenWidgetState extends State<CustomerMainScreenWidget> {
  int _selectedIndex = 0;
  late String _title;

  static List<Widget> _widgetOfPages = <Widget>[
      CustomerScreenFactory.instance.makeHomePageScreen(),
      CustomerScreenFactory.instance.makeMapPageScreen(),
      CustomerScreenFactory.instance.makeBookingPageScreen(),
      CustomerScreenFactory.instance.makeChatPageScreen(),
  ];

  @override
  void initState() {
    _title = 'Some title';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
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
                text: s.homePage,
            ),
            GButton(
                icon: Icons.location_on_rounded,
                text: 'Карта'),
            GButton(
                icon: Icons.collections_bookmark,
                text: 'Бронирование'),
            GButton(
                icon: Icons.chat,
                text: 'Чат',),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),

    );
  }
}

