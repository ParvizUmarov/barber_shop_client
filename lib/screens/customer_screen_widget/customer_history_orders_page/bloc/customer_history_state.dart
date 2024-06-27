
import 'package:barber_shop/shared/data/entity/order_info.dart';

abstract class CustomerHistoryState{}

class HistoryPageInitial extends CustomerHistoryState{}

class HistoryPageProgress extends CustomerHistoryState{}

class HistoryPageSuccess extends CustomerHistoryState{
  final List<OrderInfo> orders;

  HistoryPageSuccess({required this.orders});
}

class HistoryPageFailure extends CustomerHistoryState{
  final String errorMessage;

  HistoryPageFailure({required this.errorMessage});
}