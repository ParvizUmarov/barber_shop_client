import 'dart:developer';
import 'package:barber_shop/shared/data/repository/customer_repository.dart';
import 'package:barber_shop/shared/data/entity/barber.dart';
import 'package:barber_shop/shared/data/entity/customer.dart';
import 'package:barber_shop/shared/data/entity/user.dart';
import 'package:barber_shop/shared/data/repository/barber_repository.dart';
import 'package:barber_shop/shared/helper/display_message.dart';
import 'package:barber_shop/shared/navigation/go_router_navigation.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';

abstract class RegisterEvent {}

class RegisterProcessEvent extends RegisterEvent {
  String name;
  String surname;
  String email;
  String phone;
  String password;

  RegisterProcessEvent(
      {required this.name,
      required this.surname,
      required this.email,
      required this.phone,
      required this.password});
}

class RegisterFailureEvent extends RegisterEvent {
  BuildContext context;
  String error;

  RegisterFailureEvent(this.context, this.error);
}

class RegisterInProgressEvent extends RegisterEvent {}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final customerRepository = CustomersRepository();
  final DB _db_service = DB.instance;
  final barberRepository = BarbersRepository();
  
  RegisterBloc(RegisterState initialState, BuildContext context,
      String userType, String mainScreen)
      : super(initialState) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterProcessEvent) {
        await onRegisterProcessEvent(
            context, event, emit, userType, mainScreen);
      } else if (event is RegisterInProgressEvent) {
        await onRegisterInProgressEvent(event, emit, context);
      } else if (event is RegisterFailureEvent) {
        await onRegisterFailureEvent(event, emit, context);
      }
    }, transformer: sequential());
  }

  Future<void> onRegisterProcessEvent(
      BuildContext context,
      RegisterProcessEvent event,
      Emitter<RegisterState> emit,
      String userType,
      String mainScreen) async {
    try {
      
      if(userType == "CUSTOMER"){
        emit(RegisterInProgressState());
        log('start register');
        var response = await customerRepository.register(Customer(
            id: 0,
            name: event.name,
            surname: event.surname,
            birthday: '',
            password: event.password,
            phone: event.phone,
            mail: event.email,
            authState: false));

        Users userInfo = response.response;
        _db_service.addUser(userInfo, "CUSTOMER");

        if(response.errorMessage == null){
          emit(RegisterSuccessState());
        }else{
          emit(RegisterFailureState(response.errorMessage!));
        }
      }else {
        emit(RegisterInProgressState());
        log('start register');
        var response = await barberRepository.register(Barber(
            id: 0,
            name: event.name,
            surname: event.surname,
            birthday: '',
            password: event.password,
            phone: event.phone,
            mail: event.email,
            authState: false,
            workExperience: 1
        ));

        Users userInfo = response.response;
        _db_service.addUser(userInfo, "BARBER");

        if (response.errorMessage == null) {
          emit(RegisterSuccessState());
        } else {
          emit(RegisterFailureState(response.errorMessage!));
        }
      }
      
    } catch (e) {
      if (!context.mounted) return;
      add(RegisterFailureEvent(context, e.toString()));
    }
  }

  Future<void> onRegisterInProgressEvent(RegisterInProgressEvent event,
      Emitter<RegisterState> emit, BuildContext context) async {
    //circularProgressIndicator(context);
  }

  Future<void> onRegisterFailureEvent(RegisterFailureEvent event,
      Emitter<RegisterState> emit, BuildContext context) async {
    router.pop();
    if (!context.mounted) return;
    quickAlert(context, QuickAlertType.error, 'Ошибка', event.error.toString(),
        Colors.red);

    emit(RegisterFailureState(event.error));
  }
}

abstract class RegisterState {}

class RegisterInitialState extends RegisterState{}

class RegisterSuccessState extends RegisterState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterSuccessState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class RegisterFailureState extends RegisterState {
  final String error;

  RegisterFailureState(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterFailureState &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}

class RegisterInProgressState extends RegisterState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
