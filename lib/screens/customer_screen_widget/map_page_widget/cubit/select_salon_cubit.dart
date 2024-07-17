
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/salon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSalonCubit extends Cubit<SelectSalonState>{
  SelectSalonCubit() : super(SelectedInitial());
  
  select(Salon salon){
    log('select salon: $salon');
    emit(SelectedSuccess(salon: salon));
  }
  
  clear(){
    emit(ClearState());
  }
  
}

abstract class SelectSalonState{}

class SelectedInitial extends SelectSalonState{}

class SelectedSuccess extends SelectSalonState{
  final Salon salon;

  SelectedSuccess({required this.salon});
}

class ClearState extends SelectSalonState{}
