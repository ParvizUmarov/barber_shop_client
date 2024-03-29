import 'package:barber_shop/domain/blocs/booking_bloc.dart';
import 'package:barber_shop/firebase/firebase_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/blocs/auth_bloc.dart';
import '../../../../domain/blocs/register_bloc.dart';
import '../../../shared/navigation/route_name.dart';
import '../../auth_reset_password/forgot_password_screen.dart';
import '../../loader/loader_view_model.dart';
import '../../loader/loader_widget.dart';
import '../booking_page_widget/book_page.dart';
import '../chat_page_widget/chat_page_screen_widget.dart';
import '../customer_main_widget/customer_main_screen_widget.dart';
import '../customer_main_widget/hidden_menu_widget.dart';
import '../customer_profile_screen/customer_profile_screen_widget.dart';
import '../customer_settings_screen/customer_settings_widget.dart';
import '../entry_screen/login_screen/customer_login_widget.dart';
import '../entry_screen/register_screen/customer_register_widget.dart';
import '../home_page_widget/home_page_widget.dart';
import '../map_page_widget/map_page.dart';

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
    return BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(CustomerAuthAuthorizedState(), context,
            RouteName.customerMainScreen),
        child: CustomerProfileScreenWidget());
  }

  Widget makeSettingScreen() => CustomerSettingsScreenWidget();

  Widget makeMainScreen() => CustomerMainScreenWidget();

  Widget makeHomePageScreen() => HomePage();

  Widget makeMapPageScreen() => CustomerMapPage();

  Widget makeBookingPageScreen() => BookingPage();

  Widget makeChatPageScreen() => ChatPageWidgetScreen();

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
