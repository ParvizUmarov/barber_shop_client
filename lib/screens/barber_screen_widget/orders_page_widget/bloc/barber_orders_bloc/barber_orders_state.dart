
import 'package:barber_shop/shared/data/entity/order_info.dart';

abstract class BarberOrdersState {}

class BarberOrdersInitialState extends BarberOrdersState{}

class BarberOrdersProgressState extends BarberOrdersState{}

class BarberOrdersSuccessState extends BarberOrdersState{
  final List<OrderInfo> doneOrders;
  final List<OrderInfo> reservedOrders;
  final List<OrderInfo> canceledOrders;

  BarberOrdersSuccessState({
    required this.doneOrders,
    required this.reservedOrders,
    required this.canceledOrders
  });
}

class BarberOrdersFailure extends BarberOrdersState{
  final String errorMessage;

  BarberOrdersFailure({required this.errorMessage});
}