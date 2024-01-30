import 'dart:async';

import 'package:bloc/bloc.dart';

import '../auth_bloc/customer_auth_bloc.dart';

enum CustomerLoaderViewCubitState {unknown, authorized, notAuthorized}

class CustomerLoaderViewCubit extends Cubit<CustomerLoaderViewCubitState>{
  final CustomerAuthBloc customerAuthBloc;
  late final StreamSubscription<CustomerAuthState> authBlocSubscription;
  CustomerLoaderViewCubit(super.initialState, this.customerAuthBloc){
    customerAuthBloc.add(CustomerAuthCheckStatusEvent());
    onState(customerAuthBloc.state);
    authBlocSubscription = customerAuthBloc.stream.listen(onState);
  }

  void onState(CustomerAuthState state){
    if(state is CustomerAuthAuthorizedState){
      emit(CustomerLoaderViewCubitState.authorized);
    }else if(state is CustomerAuthNotAuthorizedState){
      emit(CustomerLoaderViewCubitState.notAuthorized);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}