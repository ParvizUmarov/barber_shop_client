import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth_bloc/barber_auth_bloc.dart';

enum BarberLoaderViewCubitState {unknown, authorized, notAuthorized}

class BarberLoaderViewCubit extends Cubit<BarberLoaderViewCubitState>{
  final BarberAuthBloc barberAuthBloc;
  late final StreamSubscription<BarberAuthState> authBlocSubscription;
  BarberLoaderViewCubit(super.initialState, this.barberAuthBloc){
    barberAuthBloc.add(BarberAuthCheckStatusEvent());
    onState(barberAuthBloc.state);
    authBlocSubscription = barberAuthBloc.stream.listen(onState);
  }

  void onState(BarberAuthState state){
    if(state is BarberAuthAuthorizedState){
      emit(BarberLoaderViewCubitState.authorized);
    }else if(state is BarberAuthNotAuthorizedState){
      emit(BarberLoaderViewCubitState.notAuthorized);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }

}