import 'dart:async';
import 'dart:developer';
import 'package:barber_shop/shared/data/entity/barber_info.dart';
import 'package:barber_shop/shared/data/entity/order_info.dart';
import 'package:barber_shop/shared/data/repository/order_repository.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitialState()) {
    on<BookingAddEvent>(_onBookingAddEvent);
  }

  final _orderRepo = OrderRepository();
  final _db = DB.instance;
  
   _onBookingAddEvent(event, emit) async {
     log('create order');
    emit(BookingProgressState());
    final userInfo = await _db.getUserInfo();

    if(userInfo == null){
      emit(BookingFailureState(errorMessage: 'You must authorized'));
    }else{
      final response = await _orderRepo.createOrder(userInfo, event.barberInfo);
      if(response.errorMessage == null){
        emit(BookingSuccessState());
      }else{
        emit(BookingFailureState(errorMessage: response.errorMessage));
      }

    }
  }
  
  
}


abstract class BookingState{
}

class BookingInitialState extends BookingState {}

class BookingProgressState extends BookingState{}

class BookingFailureState extends BookingState{
  final String? errorMessage;

  BookingFailureState({required this.errorMessage});
}

class BookingSuccessState extends BookingState {}

class BookingUpdateState extends BookingState {}

class BookingDeleteState extends BookingState {}



abstract class BookingEvent{}

class BookingAddEvent extends BookingEvent {
  final BarberInfo barberInfo;

  BookingAddEvent({required this.barberInfo});

}

