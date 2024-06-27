import 'dart:developer';
import 'package:barber_shop/shared/data/repository/customer_repository.dart';
import 'package:barber_shop/shared/data/entity/user.dart';
import 'package:barber_shop/shared/data/repository/barber_repository.dart';
import 'package:barber_shop/shared/helper/display_message.dart';
import 'package:barber_shop/shared/local_storage/local_storage.dart';
import 'package:barber_shop/shared/navigation/go_router_navigation.dart';
import 'package:barber_shop/shared/navigation/route_name.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';

enum UserType{
  customer,
  barber
}

abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  UserType userType;
  String email;
  String password;

  AuthLoginEvent({
    required this.email,
    required this.password,
    required this.userType,
  });
}

class AuthLogoutEvent extends AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {}

class CustomerAuthCheckStatusEvent extends AuthEvent {}

class AuthErrorEvent extends AuthEvent {}

class AuthResetPasswordEvent extends AuthEvent {
  String email;

  AuthResetPasswordEvent(this.email);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final String mainScreenName;
  final CustomersRepository customersRepository = CustomersRepository();
  final BarbersRepository barbersRepository = BarbersRepository();
  final DB _databaseService = DB.instance;

  AuthBloc(AuthState initialState, BuildContext context, this.mainScreenName)
      : super(initialState) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckStatusEvent) {
        await onAuthCheckStatusEvent(event, emit);
      } else if (event is AuthLoginEvent) {
        await onAuthLoginEvent(context, event, emit);
      } else if (event is AuthLogoutEvent) {
        await onAuthLogoutEvent(event, emit);
      } else if (event is AuthErrorEvent) {
        await onAuthErrorEvent(event, emit);
      } else if (event is AuthResetPasswordEvent) {
        await onAuthResetPasswordEvent(event, emit, context);
      }
    }, transformer: sequential());
    add(AuthCheckStatusEvent());
  }

  Future<void> onAuthResetPasswordEvent(AuthResetPasswordEvent event,
      Emitter<AuthState> emit, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: event.email.trim());
      if (!context.mounted) return;
      quickAlert(context, QuickAlertType.success, 'Готово!',
          'Код был отправлен на почту ${event.email}', Colors.green);
    } catch (e) {
      if (!context.mounted) return;
      quickAlert(
          context, QuickAlertType.error, 'Ошибка', e.toString(), Colors.red);
    }
  }

  Future<void> onAuthCheckStatusEvent(
      AuthCheckStatusEvent event, Emitter<AuthState> emit) async {
    Users? users = await _databaseService.getUserInfo();
    if(users == null){
      emit(AuthUnknownState());
    }else if(users.type == "CUSTOMER"){
      emit(CustomerAuthAuthorizedState());
    }else if(users.type == "BARBER"){
      emit(BarberAuthAuthorizedState());
    }

  }

  Future<void> onAuthLoginEvent( context, event, emit) async {
    emit(CustomerAuthInProgressState());
    
    if(event.userType == UserType.customer){
      var response = await customersRepository.login(event.email, event.password);
      log('error: ${response.errorMessage}');

      if(response.errorMessage == null){
        Users user = response.response;
        log('bloc response: $user');
        _databaseService.addUser(user, 'CUSTOMER');
        emit(CustomerAuthAuthorizedState());
      }else{
        emit(CustomerFailureState(errorMessage: 'Не правильный email или пароль'));
      }
    }else{
      emit(BarberAuthInProgressState());
      final response = await barbersRepository.login(
          event.email, event.password);
      if (response.response != null) {
        Users user = response.response;
        log('bloc response: $user');
        _databaseService.addUser(user, 'BARBER');
        emit(BarberAuthAuthorizedState());
      }else{
        emit(BarberFailureState(errorMessage: "Не правильный email или пароль"));
      }
    }
  }
}


Future<void> onAuthLogoutEvent(
    AuthLogoutEvent event, Emitter<AuthState> emit) async {
  try {
    await FirebaseAuth.instance.signOut();
    router.pushReplacementNamed(RouteName.startScreen);
  } catch (e) {
    emit(AuthFailureState(e));
  }
}

Future<void> onAuthErrorEvent(
    AuthErrorEvent event, Emitter<AuthState> emit) async {
  try {} catch (e) {
    emit(AuthFailureState(e));
  }
}

abstract class AuthState {}

class AuthUnknownState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUnknownState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthFailureState extends AuthState {
  final Object error;

  AuthFailureState(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthFailureState &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}

//====================================================================
// ------------------------BARBER AUTH STATE----------------------------
//====================================================================

class BarberAuthNotAuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthNotAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BarberAuthAuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BarberAuthInProgressState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BarberAuthCheckStatusInProgressState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthCheckStatusInProgressState &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BarberFailureState extends AuthState {
  final String errorMessage;

  BarberFailureState({required this.errorMessage});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BarberAuthCheckStatusInProgressState &&
              runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

//====================================================================
// ------------------------CUSTOMER AUTH STATE----------------------------
//====================================================================

class CustomerAuthNotAuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthNotAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class CustomerAuthAuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class CustomerAuthInProgressState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class CustomerAuthCheckStatusInProgressState extends AuthState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthCheckStatusInProgressState &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class CustomerFailureState extends AuthState {
  final String errorMessage;

  CustomerFailureState({required this.errorMessage});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthCheckStatusInProgressState &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}


