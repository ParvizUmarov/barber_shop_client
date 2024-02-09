import 'package:barber_shop/firebase/firebase_collections.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/entry_screen/login_screen/barber_login_widget.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/main_screen/barber_menu_screens/barber_profile_screen/barber_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../../../domain/blocs/register_bloc/register_bloc.dart';
import '../../../navigation/route_name.dart';
import '../../auth_reset_password/forgot_password_screen.dart';
import '../entry_screen/register_screen/barber_register_widget.dart';
import '../main_screen/barber_menu_screens/barber_main_screen/hidden_menu_widget.dart';

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
      create: (context) => RegisterBloc(RegisterInProgressState(), context,
          FirebaseCollections.barbers, RouteName.barberMainScreen),
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
