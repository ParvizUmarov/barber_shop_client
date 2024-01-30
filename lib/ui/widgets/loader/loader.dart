
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../barber_screen_widget/auth_bloc/barber_auth_bloc.dart';
import '../barber_screen_widget/loader/barber_loader_view_model.dart';
import '../customer_screen_widget/auth_bloc/customer_auth_bloc.dart';
import '../customer_screen_widget/loader/customer_loader_view_model.dart';
import 'loader_widget.dart';

class Loader{

  static final instance = Loader._();

  Loader._();

  BarberAuthBloc? _barberAuthBloc;
  CustomerAuthBloc? _customerAuthBloc;

  Widget makeLoaderScreen(BuildContext context) {

    final barAuthBloc = _barberAuthBloc ??
        BarberAuthBloc(
            BarberAuthCheckStatusInProgressState(), context, 'barberMainScreen');
    _barberAuthBloc = barAuthBloc;

    final authBloc = _customerAuthBloc ??
        CustomerAuthBloc(CustomerAuthCheckStatusInProgressState(), context,
            'customerMainScreen');
    _customerAuthBloc = authBloc;

    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => BarberLoaderViewCubit(
            BarberLoaderViewCubitState.unknown, barAuthBloc),
        lazy: false,
        child: LoaderWidget(),
      ),
      BlocProvider(
        create: (_) => CustomerLoaderViewCubit(
            CustomerLoaderViewCubitState.unknown, authBloc),
        lazy: false,
        child: LoaderWidget(),
      ),
    ], child: LoaderWidget());
  }


  
}