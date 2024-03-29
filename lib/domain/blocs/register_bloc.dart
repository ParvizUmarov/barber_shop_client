import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import '../../widgets/shared/helper/display_message.dart';
import '../../widgets/shared/navigation/go_router_navigation.dart';

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
  Object error;

  RegisterFailureEvent(this.context, this.error);
}

class RegisterInProgressEvent extends RegisterEvent {}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(RegisterState initialState, BuildContext context,
      String nameOfCollection, String mainScreen)
      : super(initialState) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterProcessEvent) {
        await onRegisterProcessEvent(
            context, event, emit, nameOfCollection, mainScreen);
      } else if (event is RegisterInProgressEvent) {
        await onRegisterInProgressEvent(event, emit, context);
      } else if (event is RegisterFailureEvent) {
        await onRegisterFailureEvent(event, emit, context);
      }
    }, transformer: sequential());
    add(RegisterInProgressEvent());
  }

  Future<void> onRegisterProcessEvent(
      BuildContext context,
      RegisterProcessEvent event,
      Emitter<RegisterState> emit,
      String nameOfCollection,
      String mainScreen) async {
    try {
      circularProgressIndicator(context);

      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password);

      if (!context.mounted) return;
      if (userCredential.user != null) {
        await firebaseFirestore
            .collection(nameOfCollection)
            .doc(userCredential.user!.uid)
            .set({
          'uid': userCredential.user!.uid,
          'email': event.email,
          'name': event.name,
          'surname': event.surname,
          'phone': event.phone
        });
      }
      if (!context.mounted) return;
      await quickAlert(context, QuickAlertType.success, 'Готово!',
          'Регистрация прошла успешно', Colors.green);
      router.pop();
      router.pushReplacementNamed(mainScreen);
      emit(RegisterSuccessState());
    } catch (e) {
      if (!context.mounted) return;
      add(RegisterFailureEvent(context, e));
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

class RegisterSuccessState extends RegisterState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterSuccessState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class RegisterFailureState extends RegisterState {
  final Object error;

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
