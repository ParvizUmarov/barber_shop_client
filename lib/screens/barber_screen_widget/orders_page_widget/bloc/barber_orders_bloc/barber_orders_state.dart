
import 'package:barber_shop/shared/data/entity/order_info.dart';

abstract class BarberOrdersState {}

class BarberOrdersInitialState extends BarberOrdersState{}

class BarberOrdersProgressState extends BarberOrdersState{}

class BarberOrdersSuccessState extends BarberOrdersState{
  final List<OrderInfo> barberOrders;

  BarberOrdersSuccessState({required this.barberOrders});
}

class BarberOrdersFailure extends BarberOrdersState{
  final String errorMessage;

  BarberOrdersFailure({required this.errorMessage});
}