import 'dart:developer';

import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_state.dart';
import 'package:barber_shop/shared/localization/s.dart';
import 'package:barber_shop/shared/navigation/go_router_navigation.dart';
import 'package:barber_shop/shared/navigation/route_name.dart';
import 'package:barber_shop/shared/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../../shared/theme/colors/Colors.dart';
import '../../factories/customer_screen_factory.dart';


class CustomerScaffoldNavBar extends StatefulWidget {
  final Widget child;
  const CustomerScaffoldNavBar({super.key, required this.child});

  @override
  State<CustomerScaffoldNavBar> createState() => _CustomerScaffoldNavBarState();
}

class _CustomerScaffoldNavBarState extends State<CustomerScaffoldNavBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

      void changeTab(int index) {
        switch(index){
          case 0:
            context.go(Routes.customerHomePage);
            break;
          case 1:
            context.go(Routes.customerMapPage);
            break;
            case 2:
            context.go(Routes.customerBookingPage);
            break;
            case 3:
            context.go(Routes.customerChatPage);
            break;
          default:
            context.go(Routes.customerHomePage);
            break;
        }
        setState(() {
          selectedIndex = index;
        });
      }

      Widget getTitle(int index){
        if(index == 0){
          return Text('Главная');
        }else if(index == 1){
          return Text('Карта');
        }else if(index == 2){
          return Text('Бронирование');
        }else{
          return Text('Чат');
        }
      }

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: getTitle(selectedIndex),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: changeTab,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_rounded),
            label: 'Карта'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            label: 'Бронирование'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Чат'
          ),

      ],)
      // Container(
      //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      //   decoration: BoxDecoration(
      //     color: Theme.of(context).colorScheme.primary,
      //   ),
      //   child: GNav(
      //     tabBackgroundColor: AppColors.mainColor,
      //     activeColor: Colors.white,
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     tabBorderRadius: 24,
      //     padding: EdgeInsets.all(10),
      //     color: Colors.grey,
      //     iconSize: 25,
      //     gap: 10,
      //     tabs: [
      //       GButton(
      //           icon: Icons.home,
      //           text: s.homePage,
      //       ),
      //       GButton(
      //           icon: Icons.location_on_rounded,
      //           text: 'Карта'),
      //       GButton(
      //           icon: Icons.collections_bookmark,
      //           text: 'Бронирование'),
      //       GButton(
      //           icon: Icons.chat,
      //           text: 'Чат',),
      //     ],
      //     selectedIndex: _selectedIndex,
      //     onTabChange: (index){
      //       setState(() {
      //         _selectedIndex = index;
      //       });
      //     },
      //   ),
      // ),

    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CustomerProfileBloc()..add(GetProfileInfo()),
      child: Drawer(
        elevation: 5,
        backgroundColor: Theme.of(context).colorScheme.background,
        child: BlocConsumer<CustomerProfileBloc, CustomerProfileState>(
          listener: (context, state){
            if(state is LogoutSuccess){
              context.pushReplacementNamed(Routes.startScreen);
            }
          },
          builder: (context, state) {
            if(state is CustomerProgressState){
              return Center(child: ShimmerWidget(typeBox: ShimmerTypeBox.listBox));
            }else if(state is CustomerSuccessState){
              final model = state.customer;
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        color: AppColors.mainColor
                    ),
                    accountName: Text(model.name, style: TextStyle(color: Colors.white),),
                    accountEmail: Text(model.mail, style: TextStyle(color: Colors.white),),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                        child: Image.asset('assets/images/user_avatar.png'),
                      ),
                    ),),

                  ListTile(
                    leading: Icon(Icons.home, color: Colors.grey),
                    title: Text('Главная'),
                    onTap: () => context.goNamed(Routes.customerHomePage),
                  ),
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.grey),
                    title: Text('Профиль'),
                    onTap: () => context.goNamed(Routes.customerProfilePage),
                  ),
                  ListTile(
                    leading: Icon(Icons.history, color: Colors.grey,),
                    title: Text('История заказов'),
                    onTap: () => context.goNamed(Routes.customerHistoryOrderPage),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings,color: Colors.grey,),
                    title: Text('Настройки'),
                    onTap: () => context.goNamed(Routes.customerSettingPage),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.grey,),
                    title: Text('Выход'),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (dialogContext){
                            return Center(
                              child: Dialog(
                                child: SizedBox(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Вы действительно хотите выйти?', style: TextStyle(fontSize: 16),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: Theme.of(dialogContext).colorScheme.background
                                                ),
                                                onPressed: () => dialogContext.pop(),
                                                child: Text('Нет', style: TextStyle(
                                                  color: Theme.of(dialogContext).colorScheme.surface
                                                ),)),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColors.mainColor
                                                ),
                                                onPressed: () {
                                                  context.read<CustomerProfileBloc>().add(Logout());
                                                },
                                                child: Text('Да', style: TextStyle(color: Colors.white),)),

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ],
              );
            }else{
              return Center(child: Text('Упс что пошло не так!'),);
            }
          }
        ),
      ),
    );
  }
}


