
import 'package:barber_shop/shared/data/entity/order_info.dart';

abstract class CustomerOrderState{}

class CustomerInitialOrderState extends CustomerOrderState{}

class CustomerProgressOrderState extends CustomerOrderState{}

class CustomerSuccessOrderState extends CustomerOrderState{
  final List<OrderInfo> orders;

  CustomerSuccessOrderState({required this.orders});
}

class CustomerFailureOrderState extends CustomerOrderState{
  final String errorMessage;

  CustomerFailureOrderState({required this.errorMessage});
}
