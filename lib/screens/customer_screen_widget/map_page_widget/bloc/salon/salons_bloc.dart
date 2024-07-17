

import 'dart:async';

import 'package:barber_shop/screens/customer_screen_widget/map_page_widget/bloc/salon/salon_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/map_page_widget/bloc/salon/salon_state.dart';
import 'package:barber_shop/shared/data/entity/salon.dart';
import 'package:barber_shop/shared/data/repository/salon_repository.dart';
import 'package:bloc/bloc.dart';

class SalonBloc extends Bloc<SalonEvent, SalonState>{
  SalonBloc() : super(SalonInitial()){
    on<GetAllSalons>(_getAllSalons);
    on<SelectSalon>(_selectSalon);
  }

  final salonRepo = SalonRepository();

   _getAllSalons( event, emit) async {
    emit(SalonProgress());
    final response = await salonRepo.getAllSalons();

    if(response.errorMessage == null){
      final List<Salon> salons = response.response;
      emit(SalonSuccess(salons: salons));
    }else{
      emit(SalonError(errorMessage: response.errorMessage));
    }

  }

   _selectSalon( event,  emit) {
     emit(SalonProgress());
     final selectedSalon = event.salon;
     emit(SelectedSalon(salon: selectedSalon));
  }
}