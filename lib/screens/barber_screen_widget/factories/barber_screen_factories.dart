import 'package:barber_shop/shared/general_blocs/auth_bloc.dart';
import 'package:barber_shop/shared/general_blocs/register_bloc.dart';
import 'package:barber_shop/shared/firebase/firebase_collections.dart';
import 'package:barber_shop/screens/barber_screen_widget/auth_screen/login_screen/barber_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/navigation/route_name.dart';
import '../../auth_reset_password/forgot_password_screen.dart';
import '../auth_screen/register_screen/barber_register_widget.dart';
import '../barber_main_screen/hidden_menu_widget.dart';
import '../barber_profile_screen/presentation/barber_profile_screen.dart';

class BarberScreenFactory {
  static final instance = BarberScreenFactory._();

  BarberScreenFactory._();

  AuthBloc? _barberAuthBloc;

  Widget makeLoginScreen() {
    return BlocProvider<AuthBloc>(
        create: (BuildContext context) => AuthBloc(
            BarberAuthCheckStatusInProgressState(),
            context,
            RouteName.barberMainScreen),
        child: BarberLoginWidget());
  }

  Widget makeRegisterScreen() {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(RegisterInitialState(), context,
          "BARBER", RouteName.barberMainScreen),
      child: BarberRegisterWidget(),
    );
  }

  Widget makeMainScreenWidget() {
    return BarberHiddenMenuWidget();
  }

  Widget makeForgotPasswordScreen() {
    return BlocProvider<AuthBloc>(
        create: (context) =>
            AuthBloc(AuthUnknownState(), context, RouteName.barberMainScreen),
        child: ResetPasswordScreen());
  }

  Widget makeProfileScreen() {
    return BlocProvider<AuthBloc>(
        create: (BuildContext context) => AuthBloc(
            BarberAuthAuthorizedState(), context, RouteName.barberMainScreen),
        child: BarberProfileScreen());
  }
}
