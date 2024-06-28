import 'dart:async';
import 'package:barber_shop/shared/general_blocs/auth_bloc.dart';
import 'package:bloc/bloc.dart';


enum LoaderViewCubitState {
  unknown,
  barberAuthorized,
  barberNotAuthorized,
  customerAuthorized,
  customerNotAuthorized,
  newVisitor
  }

class LoaderViewCubit extends Cubit<LoaderViewCubitState>{
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;
  LoaderViewCubit(super.initialState, this.authBloc){

    authBloc.add(AuthCheckStatusEvent());
    onState(authBloc.state);
    authBlocSubscription = authBloc.stream.listen(onState);
  }

  void onState(AuthState state){
    if(state is BarberAuthAuthorizedState){
      emit(LoaderViewCubitState.barberAuthorized);
    }else if(state is BarberAuthNotAuthorizedState){
      emit(LoaderViewCubitState.barberNotAuthorized);
    }else if(state is CustomerAuthAuthorizedState){
      emit(LoaderViewCubitState.customerAuthorized);
    }else if(state is CustomerAuthNotAuthorizedState){
      emit(LoaderViewCubitState.customerNotAuthorized);
    }else if(state is AuthUnknownState){
      emit(LoaderViewCubitState.newVisitor);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}