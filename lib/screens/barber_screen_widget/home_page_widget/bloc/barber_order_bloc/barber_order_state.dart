
import 'package:barber_shop/shared/data/entity/order_info.dart';

abstract class BarberOrderState{}

class InitialOrderState extends BarberOrderState{}

class ProgressOrderState extends BarberOrderState{}

class SuccessOrderState extends BarberOrderState{
  final List<OrderInfo> orders;

  SuccessOrderState({required this.orders});
}

class FailureOrderState extends BarberOrderState{
  final String? errorMessage;

  FailureOrderState({required this.errorMessage});
}

