
import 'package:barber_shop/ui/navigation/go_router_navigation.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/entity/barber.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:barber_shop/colors/Colors.dart';

abstract class CustomerAuthEvent{}

class CustomerAuthLoginEvent extends CustomerAuthEvent{
  String email;
  String password;

  CustomerAuthLoginEvent({
    required this.email,
    required this.password});
}

class CustomerAuthLogoutEvent extends CustomerAuthEvent{}
class CustomerAuthCheckStatusEvent extends CustomerAuthEvent{}
class CustomerAuthErrorEvent extends CustomerAuthEvent{}

enum CustomerAuthStateStatus{ authorized, notAuthorized, inProgress }

abstract class CustomerAuthState{}

class CustomerAuthNotAuthorizedState extends CustomerAuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CustomerAuthNotAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class CustomerAuthAuthorizedState extends CustomerAuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CustomerAuthAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class CustomerAuthFailureState extends CustomerAuthState{
  final Object error;

  CustomerAuthFailureState(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CustomerAuthFailureState &&
              runtimeType == other.runtimeType &&
              error == other.error;

  @override
  int get hashCode => error.hashCode;
}

class CustomerAuthInProgressState extends CustomerAuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CustomerAuthInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class CustomerAuthCheckStatusInProgressState extends CustomerAuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CustomerAuthCheckStatusInProgressState &&
              runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

}

class CustomerAuthBloc extends Bloc<CustomerAuthEvent, CustomerAuthState>{
  final String mainScreenName;
  CustomerAuthBloc(CustomerAuthState initialState, BuildContext context, this.mainScreenName) : super(initialState){
    on<CustomerAuthEvent>((event, emit) async {
      if(event is CustomerAuthCheckStatusEvent){
        await onAuthCheckStatusEvent(event, emit);
      }else if(event is CustomerAuthLoginEvent){
        await onAuthLoginEvent(context, event, emit);
      }else if(event is CustomerAuthLogoutEvent){
        await onAuthLogoutEvent(event, emit);
      }else if(event is CustomerAuthErrorEvent){

      }

    }, transformer: sequential());
    add(CustomerAuthCheckStatusEvent());
  }

  Future<void> onAuthCheckStatusEvent(
      CustomerAuthCheckStatusEvent event,
      Emitter<CustomerAuthState> emit) async{
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final newState = idToken != null
        ? CustomerAuthAuthorizedState()
        : CustomerAuthNotAuthorizedState();
    emit(newState);
  }
  Future<void> onAuthLoginEvent(
      BuildContext context,
      CustomerAuthLoginEvent event,
      Emitter<CustomerAuthState> emit) async{
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


      emit(CustomerAuthAuthorizedState());
      router.pop();
      router.pushReplacementNamed(mainScreenName);
    }catch(e){
      emit(CustomerAuthFailureState(e));
    }

  }
  Future<void> onAuthLogoutEvent(
      CustomerAuthLogoutEvent event,
      Emitter<CustomerAuthState> emit)async {
    try{
      await FirebaseAuth.instance.signOut();
      router.pushReplacementNamed('/');
    }catch(e){
      emit(CustomerAuthFailureState(e));
    }
  }

  Future<void> onAuthErrorEvent(
      CustomerAuthLogoutEvent event,
      Emitter<CustomerAuthState> emit)async {
    try{
      await FirebaseAuth.instance.signOut();
    }catch(e){
      emit(CustomerAuthFailureState(e));
    }
  }
}