
import 'package:barber_shop/shared/data/entity/stores.dart';

abstract class StoresState{}

class StoresInitial extends StoresState{}

class StoresProgress extends StoresState{}

class StoresSuccess extends StoresState{
  final List<Stores> stores;

  StoresSuccess({required this.stores});
}

class StoresFailure extends StoresState{
  final String errorMessage;

  StoresFailure({required this.errorMessage});
}

