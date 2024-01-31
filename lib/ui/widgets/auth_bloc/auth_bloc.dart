import 'package:barber_shop/ui/navigation/go_router_navigation.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/entity/barber.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../colors/Colors.dart';


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
class CustomerAuthCheckStatusEvent extends AuthEvent{}
class AuthErrorEvent extends AuthEvent{}


enum AuthStateStatus{ authorized, notAuthorized, inProgress }

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
        await onAuthErrorEvent(event, emit);
      }
    }, transformer: sequential());
    add(AuthCheckStatusEvent());
  }

  Future<void> onAuthCheckStatusEvent(
      AuthCheckStatusEvent event,
      Emitter<AuthState> emit) async{
    final currentUser = FirebaseAuth.instance.currentUser;
    final idToken = await currentUser?.getIdToken();

      if(idToken != null){
        final uid = currentUser!.uid;

        await FirebaseFirestore.instance.collection('Barbers')
            .doc(uid).get().then((value){
          if(value.exists){
            emit(BarberAuthAuthorizedState());
          }
        });

        await FirebaseFirestore.instance.collection('Customers')
            .doc(uid).get().then((value){
          if(value.exists){
            emit(CustomerAuthAuthorizedState());
          }
        });

      }else{
        emit(AuthUnknownState());
      }
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
      emit(BarberAuthAuthorizedState());
      router.pop();
      router.pushReplacementNamed(mainScreenName);
    }catch(e){
      emit(BarberAuthFailureState(e));
    }

  }

  Future<void> onAuthLogoutEvent(
      AuthLogoutEvent event,
      Emitter<AuthState> emit)async {
    try{
      await FirebaseAuth.instance.signOut();
      router.pushReplacementNamed('/');
    }catch(e){
      emit(BarberAuthFailureState(e));
    }
  }

  Future<void> onAuthErrorEvent(
      AuthErrorEvent event,
      Emitter<AuthState> emit)async {
    try{
      await FirebaseAuth.instance.signOut();
    }catch(e){
      emit(BarberAuthFailureState(e));
    }
  }
}

abstract class AuthState{}

class AuthUnknownState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUnknownState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

//====================================================================
// ------------------------BARBER AUTH STATE----------------------------
//====================================================================

class BarberAuthNotAuthorizedState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BarberAuthNotAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BarberAuthAuthorizedState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BarberAuthAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BarberAuthFailureState extends AuthState{
  final Object error;

  BarberAuthFailureState(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BarberAuthFailureState &&
              runtimeType == other.runtimeType &&
              error == other.error;

  @override
  int get hashCode => error.hashCode;
}

class BarberAuthInProgressState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BarberAuthInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BarberAuthCheckStatusInProgressState extends AuthState{

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

class CustomerAuthNotAuthorizedState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BarberAuthNotAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class CustomerAuthAuthorizedState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BarberAuthAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class CustomerAuthFailureState extends AuthState{
  final Object error;

  CustomerAuthFailureState(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BarberAuthFailureState &&
              runtimeType == other.runtimeType &&
              error == other.error;

  @override
  int get hashCode => error.hashCode;
}

class CustomerAuthInProgressState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BarberAuthInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class CustomerAuthCheckStatusInProgressState extends AuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BarberAuthCheckStatusInProgressState &&
              runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

}

