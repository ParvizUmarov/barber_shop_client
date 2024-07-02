

import 'dart:async';
import 'dart:developer';

import 'package:barber_shop/screens/customer_screen_widget/booking_page_widget/bloc/customer_order_bloc/customer_order_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/booking_page_widget/bloc/customer_order_bloc/customer_order_state.dart';
import 'package:barber_shop/shared/data/repository/order_repository.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';

class CustomerOrderBloc extends Bloc<CustomerOrderEvent, CustomerOrderState>{
  CustomerOrderBloc() : super(CustomerInitialOrderState()){
    on<GetReservedCustomerOrder>(_getReservedOrders);
  }

  final _orderRepo = OrderRepository();
  final _db = DB.instance;

   _getReservedOrders(event, emit) async {
    emit(CustomerProgressOrderState());
    var userInfo = await _db.getUserInfo();

    if(userInfo == null){
      emit(CustomerFailureOrderState(errorMessage: 'You must authorized'));
    }else{
      var response = await _orderRepo.getCustomerReservedOrder(userInfo.token);
      if(response.errorMessage == null){
        log('get all reserved orders');
        emit(CustomerSuccessOrderState(orders: response.response));
      }else{
        log('error: ${response.errorMessage}');
        emit(CustomerFailureOrderState(errorMessage: response.errorMessage!));
      }

    }

  }
}