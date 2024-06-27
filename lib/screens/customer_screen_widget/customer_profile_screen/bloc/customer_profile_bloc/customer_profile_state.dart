
import 'package:barber_shop/shared/data/entity/customer.dart';

abstract class CustomerProfileState{}

class CustomerInitialState extends CustomerProfileState{}

class CustomerProgressState extends CustomerProfileState{}

class CustomerSuccessState extends CustomerProfileState{
  final Customer customer;

  CustomerSuccessState({required this.customer});
}

class LogoutSuccess extends CustomerProfileState {}

class CustomerFailureState extends CustomerProfileState{
  final String errorMessage;

  CustomerFailureState({required this.errorMessage});
}