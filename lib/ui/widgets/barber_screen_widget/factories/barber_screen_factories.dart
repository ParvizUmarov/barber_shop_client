import 'package:barber_shop/ui/widgets/barber_screen_widget/entry_screen/login_screen/barber_login_widget.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/main_screen/barber_menu_screens/barber_profile_screen/barber_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../loader/loader_widget.dart';
import '../auth_bloc/barber_auth_bloc.dart';
import '../entry_screen/register_screen/barber_register_widget.dart';
import '../loader/barber_loader_view_model.dart';
import '../main_screen/barber_menu_screens/barber_main_screen/hidden_menu_widget.dart';

class BarberScreenFactory {
  static final instance = BarberScreenFactory._();

  BarberScreenFactory._();

  BarberAuthBloc? _barberAuthBloc;

  Widget makeLoaderScreen(BuildContext context){
    final authBloc =
        _barberAuthBloc ?? BarberAuthBloc(
            BarberAuthCheckStatusInProgressState(), context, 'barberMainScreen');
    _barberAuthBloc = authBloc;
    return BlocProvider(
      create: (_) => BarberLoaderViewCubit(BarberLoaderViewCubitState.unknown, authBloc),
      lazy: false,
      child: LoaderWidget(),
    );
  }

  Widget makeLoginScreen() {
    return BlocProvider<BarberAuthBloc>(
        create: (BuildContext context) =>
            BarberAuthBloc(BarberAuthCheckStatusInProgressState(), context, 'barberMainScreen'),
        child: BarberLoginWidget());
  }

  Widget makeRegisterScreen() {
    return BarberRegisterWidget();
  }

  Widget makeMainScreenWidget() {
    return BarberHiddenMenuWidget();
  }

  Widget makeProfileScreen(){
    return BlocProvider<BarberAuthBloc>(
        create: (BuildContext context) =>
            BarberAuthBloc(BarberAuthAuthorizedState(), context, 'barberMainScreen'),
        child: BarberProfileScreen());
  }
}
