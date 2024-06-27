
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/barber.dart';
import 'package:barber_shop/shared/data/repository/barber_repository.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';

class BarberProfileCubit extends Cubit<BarberProfileState>{
  BarberProfileCubit() : super(InitialState());

  final repository = BarbersRepository();
  final db_service = DB.instance;

  getBarberData() async {
    var usersInfo = await db_service.getUserInfo();
    final response = await repository.getBarberInfo(usersInfo!.mail, usersInfo.token);

    if(response.errorMessage == null){
      final barber = response.response;
      emit(ProfileSuccess(barber: barber));
    }else{
      emit(FailureState(errorMessage: response.errorMessage!));
    }
  }

  logout() async {
    var usersInfo = await db_service.getUserInfo();
    await repository.logout(usersInfo!.mail);
    await db_service.deleteUser("BARBER");
    emit(LogoutState());
  }

}

abstract class BarberProfileState {}

class ProfileInProgress extends BarberProfileState{}

class ProfileSuccess extends BarberProfileState{
  final Barber barber;

  ProfileSuccess({required this.barber});
}

class InitialState extends BarberProfileState{}

class FailureState extends BarberProfileState {
  final String errorMessage;

  FailureState({required this.errorMessage});
}

class LogoutState extends BarberProfileState{}