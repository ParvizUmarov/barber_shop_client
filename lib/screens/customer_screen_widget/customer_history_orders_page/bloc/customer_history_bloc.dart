

import 'dart:async';
import 'dart:developer';

import 'package:barber_shop/shared/data/repository/order_repository.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_history_orders_page/bloc/customer_history_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_history_orders_page/bloc/customer_history_state.dart';
import 'package:barber_shop/shared/data/entity/order_info.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';

class CustomerHistoryBloc extends Bloc<CustomerHistoryEvent, CustomerHistoryState>{
  CustomerHistoryBloc() : super(HistoryPageInitial()){
    on<GetAllCustomerOrders>(_getAllCustomerOrders);
  }
  
  final _orderRepository = OrderRepository();
  final _db = DB.instance;
  
  _getAllCustomerOrders( event, emit) async {
    emit(HistoryPageProgress());
    var userInfo =  await _db.getUserInfo();
    if(userInfo == null){
      emit(HistoryPageFailure(errorMessage: 'Авторизуйтесь заново'));
    }else{
      var response = await _orderRepository.getOrderOfCustomer(userInfo.uid, userInfo.token);

      if(response.errorMessage == null){
        List<OrderInfo> orders = response.response;
        emit(HistoryPageSuccess(orders: orders));
      }else{
        emit(HistoryPageFailure(errorMessage: response.errorMessage!));
      }
    }
  }
}