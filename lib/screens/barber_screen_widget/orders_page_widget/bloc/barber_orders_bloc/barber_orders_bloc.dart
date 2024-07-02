

import 'dart:async';
import 'dart:developer';

import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/bloc/barber_orders_bloc/barber_orders_event.dart';
import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/bloc/barber_orders_bloc/barber_orders_state.dart';
import 'package:barber_shop/shared/data/repository/order_repository.dart';
import 'package:barber_shop/shared/data/entity/order_info.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BarberAllOrdersBloc extends Bloc<BarberOrdersEvent, BarberOrdersState>{
  BarberAllOrdersBloc() : super(BarberOrdersInitialState()){
    on<GetBarberOrder>(_getBarberOrders);
  }

  final _orderRepository = OrderRepository();
  final DB _db = DB.instance;

  _getBarberOrders(event, emit) async {
    log('get event');
    emit(BarberOrdersProgressState());
    var userInfo = await _db.getUserInfo();

    if(userInfo == null){
      emit(BarberOrdersFailure(errorMessage: "Вам нужно авторизоваться"));
    }else{
      final response = await _orderRepository.getAllOrderOfBarber(userInfo.token);

      if(response.errorMessage == null){
        log('all response: ${response.response}');
        var allData = response.response as List<List<OrderInfo>>;
        var doneList = allData[0];
        var reservedList = allData[1];
        var canceled = allData[2];

        log('doneList: $doneList');
        log('reservedList: $reservedList');
        log('canceled: $canceled');

        emit(BarberOrdersSuccessState(
            doneOrders: doneList,
            reservedOrders: reservedList,
            canceledOrders: canceled
        ));
      }else{
        emit(BarberOrdersFailure(errorMessage: response.errorMessage.toString()));
      }
    }

  }
}