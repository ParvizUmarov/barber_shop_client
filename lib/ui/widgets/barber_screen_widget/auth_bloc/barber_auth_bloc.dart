
import 'package:barber_shop/ui/navigation/go_router_navigation.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../colors/Colors.dart';


abstract class BarberAuthEvent{}

class BarberAuthLoginEvent extends BarberAuthEvent{
  String email;
  String password;

  BarberAuthLoginEvent({
    required this.email,
    required this.password});
}

class BarberAuthLogoutEvent extends BarberAuthEvent{}
class BarberAuthCheckStatusEvent extends BarberAuthEvent{}
class BarberAuthErrorEvent extends BarberAuthEvent{}

enum BarberAuthStateStatus{ authorized, notAuthorized, inProgress }

abstract class BarberAuthState{}

class BarberAuthNotAuthorizedState extends BarberAuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthNotAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BarberAuthAuthorizedState extends BarberAuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthAuthorizedState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BarberAuthFailureState extends BarberAuthState{
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

class BarberAuthInProgressState extends BarberAuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthInProgressState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BarberAuthCheckStatusInProgressState extends BarberAuthState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarberAuthCheckStatusInProgressState &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
   
}

class BarberAuthBloc extends Bloc<BarberAuthEvent, BarberAuthState>{
  final String mainScreenName;
  BarberAuthBloc(BarberAuthState initialState, BuildContext context, this.mainScreenName) : super(initialState){
    on<BarberAuthEvent>((event, emit) async {
      if(event is BarberAuthCheckStatusEvent){
        await onAuthCheckStatusEvent(event, emit);
      }else if(event is BarberAuthLoginEvent){
        await onAuthLoginEvent(context, event, emit);
      }else if(event is BarberAuthLogoutEvent){
        await onAuthLogoutEvent(event, emit);
      }else if(event is BarberAuthErrorEvent){

      }

    }, transformer: sequential());
    add(BarberAuthCheckStatusEvent());
  }

  Future<void> onAuthCheckStatusEvent(
      BarberAuthCheckStatusEvent event,
      Emitter<BarberAuthState> emit) async{
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final newState = idToken != null
        ? BarberAuthAuthorizedState()
        : BarberAuthNotAuthorizedState();
    emit(newState);
  }
  Future<void> onAuthLoginEvent(
      BuildContext context,
      BarberAuthLoginEvent event,
      Emitter<BarberAuthState> emit) async{
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

//TODO для получение из Firestore данные юзера
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('Barbers')
          .doc(uid)
          .get()
          .then((value){
        Map<String, dynamic>? mapOfData = value.data();

        DocumentSnapshot<Map<String, dynamic>> values = value;

        print('ИМЯ ПОЛЬЗОВАТЕЛЯ --> ${value['name']}');

        // var email = documentSnapshot['email'];
        // print(email);
      });



      emit(BarberAuthAuthorizedState());
      router.pop();
      router.pushReplacementNamed(mainScreenName);
    }catch(e){
      emit(BarberAuthFailureState(e));
    }

  }
  Future<void> onAuthLogoutEvent(
      BarberAuthLogoutEvent event,
      Emitter<BarberAuthState> emit)async {
    try{
      await FirebaseAuth.instance.signOut();
      router.pushReplacementNamed('/');
    }catch(e){
      emit(BarberAuthFailureState(e));
    }
  }

  Future<void> onAuthErrorEvent(
      BarberAuthLogoutEvent event,
      Emitter<BarberAuthState> emit)async {
    try{
      await FirebaseAuth.instance.signOut();
    }catch(e){
      emit(BarberAuthFailureState(e));
    }
  }
}