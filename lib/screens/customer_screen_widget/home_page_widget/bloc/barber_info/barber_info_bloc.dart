

import 'dart:async';
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/barber_info.dart';
import 'package:barber_shop/shared/data/repository/barber_repository.dart';
import 'package:barber_shop/shared/services/database/database_service.dart';
import 'package:bloc/bloc.dart';

import 'barber_info_event.dart';
import 'barber_info_state.dart';

class BarberInfoBloc extends Bloc<BarberInfoEvent, BarberInfoState>{
  BarberInfoBloc() : super(BarberInfoInitial()){
    on<GetAllBarberInfo>(_getAllBarberInfo);
  }

  final _barberRepository = BarbersRepository();
  final _db = DB.instance;

  _getAllBarberInfo( event,  emit) async {
    emit(BarberInfoProgress());
    final userInfo = await _db.getUserInfo();
    if(userInfo != null){
      var response  = await _barberRepository.getAllBarbersInfo(userInfo.mail, userInfo.token);
      log('response: ${response.response}');
      log('response error: ${response.errorMessage}');
      if(response.errorMessage == null){
        List<BarberInfo> barbers = response.response;
        emit(BarberInfoSuccess(barbersInfo: barbers));
      }else{
        emit(BarberInfoFailure(errorMessage: response.errorMessage!));
      }
    }else{
     emit(BarberInfoFailure(errorMessage: "You must authorized"));
    }
  }
}