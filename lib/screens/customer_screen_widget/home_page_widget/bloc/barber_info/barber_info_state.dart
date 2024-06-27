
import 'package:barber_shop/shared/data/entity/barber_info.dart';

abstract class BarberInfoState{}

class BarberInfoInitial extends BarberInfoState{}

class BarberInfoProgress extends BarberInfoState{}

class BarberInfoSuccess extends BarberInfoState{
  final List<BarberInfo> barbersInfo;

  BarberInfoSuccess({required this.barbersInfo});
}

class BarberInfoFailure extends BarberInfoState{
  final String errorMessage;

  BarberInfoFailure({required this.errorMessage});
}
