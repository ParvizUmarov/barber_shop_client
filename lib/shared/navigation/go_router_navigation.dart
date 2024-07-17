import 'dart:developer';

import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/chat_page.dart';
import 'package:barber_shop/screens/barber_screen_widget/factories/barber_screen_factories.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_main_widget/view/customer_main_screen_widget.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_settings_screen/setting_page.dart';
import 'package:barber_shop/screens/customer_screen_widget/factories/customer_screen_factory.dart';
import 'package:barber_shop/screens/loader/loader_page.dart';
import 'package:barber_shop/shared/data/entity/barber_info.dart';
import 'package:barber_shop/shared/data/entity/chat.dart';
import 'package:barber_shop/shared/navigation/route_name.dart';
import 'package:barber_shop/shared/navigation/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _customerScreenFactory = CustomerScreenFactory.instance;
final _barberScreenFactory = BarberScreenFactory.instance;

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(navigatorKey: _rootNavigatorKey, routes: [
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => CustomerScaffoldNavBar(
            child: child,
          ),
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: Routes.customerHomePage,
          name: Routes.customerHomePage,
          builder: (context, state) =>
              _customerScreenFactory.makeHomePageScreen(),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: Routes.customerMapPage,
          name: Routes.customerMapPage,
          builder: (context, state) =>
              _customerScreenFactory.makeMapPageScreen(),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: Routes.customerBookingPage,
          name: Routes.customerBookingPage,
          builder: (context, state) =>
              _customerScreenFactory.makeBookingPageScreen(),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: Routes.customerChatPage,
          name: Routes.customerChatPage,
          builder: (context, state) =>
              _customerScreenFactory.makeChatPageScreen(),
        ),
      ]),
  GoRoute(
    path: RoutePath.startScreenPath,
    name: Routes.startScreen,
    builder: (context, state) => StartScreenWidget(),
  ),
  GoRoute(
    path: Routes.customerSettingPage,
    name: Routes.customerSettingPage,
    builder: (context, state) => _customerScreenFactory.makeSettingScreen(),
  ),
  GoRoute(
    path: Routes.customerHistoryOrderPage,
    name: Routes.customerHistoryOrderPage,
    builder: (context, state) => _customerScreenFactory.makeCustomerHistoryPage(),
  ),
  GoRoute(
    path: Routes.customerProfilePage,
    name: Routes.customerProfilePage,
    builder: (context, state) => _customerScreenFactory.makeProfileScreen(),
  ),
  GoRoute(
      path: RoutePath.loaderPath,
      name: Routes.loaderScreen,
      builder: (context, state) =>
          _customerScreenFactory.makeLoaderScreen(context),
      routes: [
        GoRoute(
          path: RoutePath.customerLoginPath,
          name: Routes.customerLoginScreen,
          builder: (context, state) =>
              _customerScreenFactory.makeCustomerLoginWidget(),
        ),
        GoRoute(
          path: RoutePath.customerRegisterPath,
          name: Routes.customerRegisterScreen,
          builder: (context, state) =>
              _customerScreenFactory.makeCustomerRegisterScreen(),
        ),
        GoRoute(
          path: RoutePath.customerResetPasswordPath,
          name: Routes.customerResetPasswordScreen,
          builder: (context, state) =>
              _customerScreenFactory.makeForgotPasswordScreen(),
        ),
        // GoRoute(
        //   path: RoutePath.customerMainPath,
        //   name: Routes.customerMainScreen,
        //   builder: (context, state) =>
        //       _customerScreenFactory.makeCustomerHiddenMenuWidget(),
        //   routes: [
        //     GoRoute(
        //         path: RoutePath.customerBarberDetail,
        //         name: Routes.customerBarberDetail,
        //         builder: (context, state) {
        //           var barberInfo =  state.extra as BarberInfo;
        //           return _customerScreenFactory.makeBarberDetailsScreen(barberInfo);
        //         }
        //     ),
        //   ]
        // ),
        GoRoute(
          path: RoutePath.barberLoginPath,
          name: Routes.barberLoginScreen,
          builder: (context, state) => _barberScreenFactory.makeLoginScreen(),
        ),
        GoRoute(
          path: RoutePath.barberResetPasswordPath,
          name: Routes.barberResetPasswordScreen,
          builder: (context, state) =>
              _barberScreenFactory.makeForgotPasswordScreen(),
        ),
        GoRoute(
          path: RoutePath.barberRegisterPath,
          name: Routes.barberRegisterScreen,
          builder: (context, state) =>
              _barberScreenFactory.makeRegisterScreen(),
        ),
        GoRoute(
          path: RoutePath.barberMainPath,
          name: Routes.barberMainScreen,
          builder: (context, state) =>
              _barberScreenFactory.makeMainScreenWidget(),
        ),
        GoRoute(
          path: Routes.barberMessageScreen,
          name: Routes.barberMessageScreen,
          builder: (context, state) {
            final chat = state.extra as Chat;
            return BarberChatRoom(
                key: state.pageKey,
                receiverUserEmail: 'customer${chat.customerId}@gmail.com',
                receivedUserId: chat.customerId.toString(),
                chatID: chat.id);
          },
        ),
      ]),
]);
