

import 'dart:async';
import 'dart:developer';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:barber_shop/shared/navigation/go_router_navigation.dart';
import 'package:barber_shop/shared/navigation/route_name.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_profile_screen/bloc/customer_profile_bloc/customer_profile_state.dart';
import 'package:barber_shop/shared/data/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';

class CustomerProfileBloc extends Bloc<CustomerProfileEvent, CustomerProfileState>{
  CustomerProfileBloc() : super(CustomerInitialState()){
    on<GetProfileInfo>(_getProfileInfo);
    on<Logout>(_onLogoutEvent);
  }

  final CustomersRepository _customersRepository = CustomersRepository();
  final DB _databaseService = DB.instance;
  
  _getProfileInfo(event, emit) async {
    emit(CustomerProgressState());
    var user = await _databaseService.getUserInfo();
    var response = await _customersRepository.getProfileInfo(user!.token);

    if(response.response != null){
      emit(CustomerSuccessState(customer: response.response));
    }else{
      emit(CustomerFailureState(errorMessage: response.errorMessage!));
    }
  }

  _onLogoutEvent(event, emit) async {
    emit(CustomerProgressState());
    var user = await _databaseService.getUserInfo();
    log("onLogout event");
    var response = await _customersRepository.logout(user!.token);
    if(response.errorMessage == null){
      await _databaseService.deleteUser("CUSTOMER");
      emit(LogoutSuccess());
      router.pushReplacementNamed(RouteName.startScreen);
      log("LogoutSuccess");
    }else{
      emit(CustomerFailureState(errorMessage: response.errorMessage!));
    }
  }
}