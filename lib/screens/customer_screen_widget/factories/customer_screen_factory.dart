
import 'package:barber_shop/screens/customer_screen_widget/booking_page_widget/bloc/customer_order_bloc/customer_order_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_history_orders_page/bloc/customer_history_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_history_orders_page/presentation/customer_history_page.dart';
import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/bloc/barber_info/barber_info_bloc.dart';
import 'package:barber_shop/shared/general_blocs/auth_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/presentation/customer_profile_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import '../../../shared/navigation/route_name.dart';
import '../../auth_reset_password/forgot_password_screen.dart';
import '../../loader/loader_view_model.dart';
import '../../loader/loader_widget.dart';
import '../booking_page_widget/presentation/book_page.dart';
import '../chat_page_widget/chat_page_screen_widget.dart';
import '../customer_main_widget/customer_main_screen_widget.dart';
import '../customer_main_widget/hidden_menu_widget.dart';
import '../customer_settings_screen/customer_settings_widget.dart';
import '../entry_screen/login_screen/customer_login_widget.dart';
import '../entry_screen/register_screen/customer_register_widget.dart';
import '../home_page_widget/presentation/home_page_widget.dart';
import '../map_page_widget/presentation/map_page.dart';

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
