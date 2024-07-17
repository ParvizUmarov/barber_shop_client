
import '../../../../../shared/data/entity/salon.dart';

abstract class SalonState{}

class SalonInitial extends SalonState{}

class SalonProgress extends SalonState{}

class SalonError extends SalonState{
  final String? errorMessage;

  SalonError({required this.errorMessage});
}

class SalonSuccess extends SalonState{
  final List<Salon> salons;

  SalonSuccess({required this.salons});
}

class SelectedSalon extends SalonState {
  final Salon salon;

  SelectedSalon({required this.salon});
}