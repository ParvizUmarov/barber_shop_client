

import 'dart:async';
import 'dart:developer';

import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/bloc/barber_orders_bloc/barber_orders_event.dart';
import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/bloc/barber_orders_bloc/barber_orders_state.dart';
import 'package:barber_shop/shared/data/repository/order_repository.dart';
import 'package:barber_shop/shared/data/entity/order_info.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';

class BarberOrdersBloc extends Bloc<BarberOrdersEvent, BarberOrdersState>{
  BarberOrdersBloc() : super(BarberOrdersInitialState()){
    on<GetBarberOrder>(_getBarberOrders);
  }

  final _orderRepository = OrderRepository();
  final DB _db = DB.instance;

  _getBarberOrders(event, emit) async {
    emit(BarberOrdersProgressState());
    var userInfo = await _db.getUserInfo();

    if(userInfo == null){
      emit(BarberOrdersFailure(errorMessage: "Вам нужно авторизоваться"));
    }else{
      final response = await _orderRepository.getOrderOfBarber(userInfo.uid, userInfo.token);

      if(response.errorMessage == null){
        emit(BarberOrdersSuccessState(barberOrders: response.response));
      }else{
        emit(BarberOrdersFailure(errorMessage: response.errorMessage.toString()));
      }
    }

  }
}