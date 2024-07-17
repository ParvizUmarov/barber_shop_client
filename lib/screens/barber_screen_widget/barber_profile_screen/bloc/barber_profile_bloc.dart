
import 'package:barber_shop/shared/data/entity/barber.dart';
import 'package:barber_shop/shared/data/repository/barber_repository.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';

class BarberProfileBloc extends Bloc<BarberProfileEvent, BarberProfileState>{
  BarberProfileBloc() : super(InitialState()){
    on<GetBarberProfileInfo>(_getProfileInfo);
    on<Logout>(_logout);
  }

  final repository = BarbersRepository();
  final db = DB.instance;

   _getProfileInfo( event,  emit) async {
    emit(ProfileInProgress());
    var usersInfo = await db.getUserInfo();
    final response = await repository.getBarberProfileInfo(usersInfo!.token);
    if(response.errorMessage == null){
      final barber = response.response;
      emit(ProfileSuccess(barber: barber));
    }else{
      emit(FailureState(errorMessage: response.errorMessage!));
    }
  }

   _logout( event,  emit) async {
     emit(ProfileInProgress());
     var usersInfo = await db.getUserInfo();
     await repository.logout(usersInfo!.mail);
     await db.deleteUser("BARBER");
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


abstract class BarberProfileEvent{}

class GetBarberProfileInfo extends BarberProfileEvent{}

class Logout extends BarberProfileEvent{}