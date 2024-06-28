
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/chat_page.dart';
import 'package:barber_shop/screens/barber_screen_widget/factories/barber_screen_factories.dart';
import 'package:barber_shop/screens/customer_screen_widget/factories/customer_screen_factory.dart';
import 'package:barber_shop/screens/loader/loader_page.dart';
import 'package:barber_shop/shared/data/entity/chat.dart';
import 'package:barber_shop/shared/navigation/route_name.dart';
import 'package:barber_shop/shared/navigation/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final _customerScreenFactory = CustomerScreenFactory.instance;
final _barberScreenFactory = BarberScreenFactory.instance;

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
  GoRoute(
    path: RoutePath.startScreenPath,
    name: RouteName.startScreen,
    builder: (context, state) => StartScreenWidget(),
  ),
  GoRoute(
      path: RoutePath.loaderPath,
      name: RouteName.loaderScreen,
      builder: (context, state) =>
          _customerScreenFactory.makeLoaderScreen(context),
      routes: [
        GoRoute(
          path: RoutePath.customerLoginPath,
          name: RouteName.customerLoginScreen,
          builder: (context, state) =>
              _customerScreenFactory.makeCustomerLoginWidget(),
        ),
        GoRoute(
          path: RoutePath.customerRegisterPath,
          name: RouteName.customerRegisterScreen,
          builder: (context, state) =>
              _customerScreenFactory.makeCustomerRegisterScreen(),
        ),
        GoRoute(
          path: RoutePath.customerResetPasswordPath,
          name: RouteName.customerResetPasswordScreen,
          builder: (context, state) =>
              _customerScreenFactory.makeForgotPasswordScreen(),
        ),
        GoRoute(
          path: RoutePath.customerMainPath,
          name: RouteName.customerMainScreen,
          builder: (context, state) =>
              _customerScreenFactory.makeCustomerHiddenMenuWidget(),
        ),
        GoRoute(
          path: RoutePath.barberLoginPath,
          name: RouteName.barberLoginScreen,
          builder: (context, state) => _barberScreenFactory.makeLoginScreen(),
        ),
        GoRoute(
          path: RoutePath.barberResetPasswordPath,
          name: RouteName.barberResetPasswordScreen,
          builder: (context, state) =>
              _barberScreenFactory.makeForgotPasswordScreen(),
        ),
        GoRoute(
          path: RoutePath.barberRegisterPath,
          name: RouteName.barberRegisterScreen,
          builder: (context, state) =>
              _barberScreenFactory.makeRegisterScreen(),
        ),
        GoRoute(
          path: RoutePath.barberMainPath,
          name: RouteName.barberMainScreen,
          builder: (context, state) =>
              _barberScreenFactory.makeMainScreenWidget(),
        ),
        GoRoute(
          path: RouteName.barberMessageScreen,
          name: RouteName.barberMessageScreen,
          builder: (context, state) {
            final chat = state.extra as Chat;
            return BarberChatRoom(
              key: state.pageKey,
              receiverUserEmail: 'customer${chat.customerId}@gmail.com', receivedUserId: chat.customerId.toString(),
              chatID: chat.id);
          },
        ),
      ]),
]);
