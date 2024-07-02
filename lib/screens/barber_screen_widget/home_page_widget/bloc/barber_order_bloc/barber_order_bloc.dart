
import 'dart:async';

import 'package:barber_shop/screens/barber_screen_widget/home_page_widget/bloc/barber_order_bloc/barber_order_event.dart';
import 'package:barber_shop/screens/barber_screen_widget/home_page_widget/bloc/barber_order_bloc/barber_order_state.dart';
import 'package:barber_shop/shared/data/repository/order_repository.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';

class BarberReservedOrderBloc extends Bloc<BarberOrderEvent, BarberOrderState>{
  BarberReservedOrderBloc() : super(InitialOrderState()){
    on<GetAllReservedOrder>(_getAllReservedOrder);
  }

  final _orderRepo = OrderRepository();
  final _db = DB.instance;

   _getAllReservedOrder( event,  emit) async {
    emit(ProgressOrderState());
    final userInfo = await _db.getUserInfo();

    if(userInfo == null){
      emit(FailureOrderState(errorMessage: 'You must authorized'));
    }else{
      final response = await _orderRepo.getBarberReservedOrder(userInfo.token);
      if(response.errorMessage == null){
        emit(SuccessOrderState(orders: response.response));
      }else{
        emit(FailureOrderState(errorMessage: response.errorMessage));
      }
    }
  }
}