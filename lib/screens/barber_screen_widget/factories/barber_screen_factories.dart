import 'package:barber_shop/screens/barber_screen_widget/auth_screen/auth_screen.dart';
import 'package:barber_shop/screens/barber_screen_widget/barber_main_screen/barber_main_page.dart';
import 'package:barber_shop/screens/barber_screen_widget/barber_profile_screen/barber_profile_page.dart';
import 'package:barber_shop/screens/barber_screen_widget/barber_settings_screen/barber_setting_page.dart';
import 'package:barber_shop/screens/barber_screen_widget/chat_page_widget/widget/chat_page_widget.dart';
import 'package:barber_shop/screens/barber_screen_widget/home_page_widget/bloc/barber_order_bloc/barber_order_bloc.dart';
import 'package:barber_shop/screens/barber_screen_widget/home_page_widget/home_page.dart';
import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/bloc/barber_orders_bloc/barber_orders_bloc.dart';
import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/orders_page.dart';
import 'package:barber_shop/shared/general_blocs/auth_bloc.dart';
import 'package:barber_shop/shared/general_blocs/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/navigation/route_name.dart';
import '../barber_main_screen/widget/hidden_menu_widget.dart';

class BarberScreenFactory {
  static final instance = BarberScreenFactory._();

  BarberScreenFactory._();

  AuthBloc? _barberAuthBloc;

  Widget makeLoginScreen() {
    return BlocProvider<AuthBloc>(
        create: (BuildContext context) => AuthBloc(
            BarberAuthCheckStatusInProgressState(),
            context,
            Routes.barberMainScreen),
        child: BarberLoginWidget());
  }

  Widget makeRegisterScreen() {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(RegisterInitialState(), context,
          "BARBER", Routes.barberMainScreen),
      child: BarberRegisterWidget(),
    );
  }

  Widget makeMainScreenWidget() {
    return BarberHiddenMenuWidget();
  }

  Widget makeForgotPasswordScreen() {
    return BlocProvider<AuthBloc>(
        create: (context) =>
            AuthBloc(AuthUnknownState(), context, Routes.barberMainScreen),
        child: ResetPasswordScreen());
  }

  Widget makeProfileScreen() {
    return BlocProvider<AuthBloc>(
        create: (BuildContext context) => AuthBloc(
            BarberAuthAuthorizedState(), context, Routes.barberMainScreen),
        child: BarberProfileScreen());
  }

  Widget makeHomeScreen() {
    return BlocProvider(
        create: (context) => BarberReservedOrderBloc(),
        child: BarberHomePage()
    );
  }

  Widget makeChatPage() {
    return BarberChatPage();
  }

  Widget makeOrderPage() {
    return BlocProvider<BarberAllOrdersBloc>(
        create: (context) => BarberAllOrdersBloc(), child: BarberOrdersPage());
  }

  Widget makeMainScreen() {
    return BarberMainScreenWidget();
  }

  Widget makeSettingScreen() {
    return BarberSettingsWidget();
  }
}
