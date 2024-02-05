import 'package:barber_shop/ui/helper/display_message.dart';
import 'package:barber_shop/ui/navigation/go_router_navigation.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';


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
class AuthResetPasswordEvent extends AuthEvent{
  String email;
  AuthResetPasswordEvent(this.email);
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
        await onAuthErrorEvent(event, emit);
      }else if(event is AuthResetPasswordEvent){
        await onAuthResetPasswordEvent(event, emit, context);
      }
    }, transformer: sequential());
    add(AuthCheckStatusEvent());
  }


  Future<void> onAuthResetPasswordEvent(
      AuthResetPasswordEvent event,
      Emitter<AuthState> emit,
      BuildContext context
      ) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: event.email.trim());
      if(!context.mounted) return;
      quickAlert(
          context,
          QuickAlertType.success,
          'Готово!',
          'Код был отправлен на почту ${event.email}',
          Colors.green);


    }catch(e){
      if(!context.mounted) return;
      quickAlert(
          context,
          QuickAlertType.error,
          'Ошибка',
          e.toString(),
          Colors.red);
    }
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

      circularProgressIndicator(context);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email ,
          password: event.password
      );
      //emit(BarberAuthAuthorizedState());
      if(!context.mounted) return;
      await quickAlert(
          context,
          QuickAlertType.success,
          'Готово!',
          'Авторизация прошла успешно',
          Colors.green);
      router.pop();
      router.pushReplacementNamed(mainScreenName);
    }catch(e){
      //emit(AuthFailureState(e));
      router.pop();
      if (!context.mounted) return;
      quickAlert(
          context,
          QuickAlertType.error,
          'Ошибка',
          e.toString(),
          Colors.red);
    }
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
      AuthErrorEvent event,
      Emitter<AuthState> emit)async {
    try{

    }catch(e){
      emit(AuthFailureState(e));
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

