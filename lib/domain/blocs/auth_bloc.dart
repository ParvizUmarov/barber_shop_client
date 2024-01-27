
import 'package:barber_shop/ui/navigation/go_router_navigation.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/entity/barber.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../colors/Colors.dart';

abstract class AuthEvent{}

class AuthLoginEvent extends AuthEvent{
  String email;
  String password;

  AuthLoginEvent({
    required this.email,
    required this.password});
}

class AuthLogoutEvent extends AuthEvent{}
class AuthCheckStatusEvent extends AuthEvent{}
class AuthErrorEvent extends AuthEvent{}

enum AuthStateStatus{ authorized, notAuthorized, inProgress }

abstract class AuthState{}

class AuthNotAuthorizedState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthNotAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthAuthorizedState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthFailureState extends AuthState{
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

class AuthInProgressState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class AuthCheckStatusInProgressState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthCheckStatusInProgressState &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
   
}

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final String mainScreenName;
  AuthBloc(AuthState initialState, BuildContext context, this.mainScreenName) : super(initialState){
    on<AuthEvent>((event, emit) async {
      if(event is AuthCheckStatusEvent){
        await onAuthCheckStatusEvent(event, emit);
      }else if(event is AuthLoginEvent){
        await onAuthLoginEvent(context, event, emit);
      }else if(event is AuthLogoutEvent){
        await onAuthLogoutEvent(event, emit);
      }else if(event is AuthErrorEvent){

      }

    }, transformer: sequential());
    add(AuthCheckStatusEvent());
  }

  Future<void> onAuthCheckStatusEvent(
      AuthCheckStatusEvent event,
      Emitter<AuthState> emit) async{
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final newState = idToken != null
        ? AuthAuthorizedState()
        : AuthNotAuthorizedState();
    emit(newState);
  }
  Future<void> onAuthLoginEvent(
      BuildContext context,
      AuthLoginEvent event,
      Emitter<AuthState> emit) async{
    try{

      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          }
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email ,
          password: event.password
      );


      emit(AuthAuthorizedState());
      router.pop();
      router.pushReplacementNamed(mainScreenName);
    }catch(e){
      emit(AuthFailureState(e));
    }

  }
  Future<void> onAuthLogoutEvent(
      AuthLogoutEvent event,
      Emitter<AuthState> emit)async {
    try{
      await FirebaseAuth.instance.signOut();
      router.pushReplacementNamed('/');
    }catch(e){
      emit(AuthFailureState(e));
    }
  }

  Future<void> onAuthErrorEvent(
      AuthLogoutEvent event,
      Emitter<AuthState> emit)async {
    try{
      await FirebaseAuth.instance.signOut();
    }catch(e){
      emit(AuthFailureState(e));
    }
  }
}