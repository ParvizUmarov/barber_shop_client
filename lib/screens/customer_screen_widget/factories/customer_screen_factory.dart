
import 'package:barber_shop/screens/customer_screen_widget/booking_page_widget/bloc/customer_order_bloc/customer_order_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/booking_page_widget/booking_page.dart';
import 'package:barber_shop/screens/customer_screen_widget/chat_page_widget/chat_page.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_history_orders_page/bloc/customer_history_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_history_orders_page/history_page.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_main_widget/main_page.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/profile_page.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_settings_screen/setting_page.dart';
import 'package:barber_shop/screens/customer_screen_widget/entry_screen/entry_page.dart';
import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/bloc/barber_info/barber_info_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/map_page_widget/map_page.dart';
import 'package:barber_shop/shared/general_blocs/auth_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/navigation/route_name.dart';
import '../../loader/widget/loader_view_model.dart';
import '../../loader/widget/loader_widget.dart';
import '../customer_main_widget/widget/hidden_menu_widget.dart';
import '../home_page_widget/home_page.dart';

class CustomerScreenFactory {
  static final instance = CustomerScreenFactory._();

  CustomerScreenFactory._();

  AuthBloc? _customerAuthBloc;

  Widget makeLoaderScreen(BuildContext context) {
    final authBloc = _customerAuthBloc ??
        AuthBloc(CustomerAuthCheckStatusInProgressState(), context,
            RouteName.customerMainScreen);
    _customerAuthBloc = authBloc;
    return BlocProvider(
      create: (_) => LoaderViewCubit(LoaderViewCubitState.unknown, authBloc),
      lazy: false,
      child: LoaderWidget(),
    );
  }

  Widget makeProfileScreen() {
    return BlocProvider(
        create: (context) => CustomerProfileBloc()..add(GetProfileInfo()),
        child: CustomerProfileScreenWidget());
  }

  Widget makeSettingScreen() => CustomerSettingsScreenWidget();

  Widget makeMainScreen() => CustomerMainScreenWidget();

  Widget makeHomePageScreen() => BlocProvider<BarberInfoBloc>(
      create: (context) => BarberInfoBloc(),
      child: HomePage());

  Widget makeMapPageScreen() => CustomerMapPage();

  Widget makeBookingPageScreen() => BlocProvider(
      create: (context) => CustomerOrderBloc(),
      child: BookingPage());

  Widget makeChatPageScreen() => ChatPageWidgetScreen();

  Widget makeCustomerHistoryPage() => BlocProvider<CustomerHistoryBloc>(
      create: (context) => CustomerHistoryBloc(),
      child: CustomerHistoryPage());

  Widget makeForgotPasswordScreen() {
    return BlocProvider<AuthBloc>(
        create: (context) =>
            AuthBloc(AuthUnknownState(), context, RouteName.customerMainScreen),
        child: ResetPasswordScreen());
  }

  Widget makeCustomerRegisterScreen() {
    return CustomerRegisterWidget();
  }

  Widget makeCustomerHiddenMenuWidget() => CustomerHiddenMenuWidget();

  Widget makeCustomerLoginWidget() {
    return BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(CustomerAuthCheckStatusInProgressState(),
            context, RouteName.customerMainScreen),
        child: CustomerLoginWidget());
  }
}
