
import '../../../../../shared/data/entity/salon.dart';

abstract class SalonEvent{}

class GetAllSalons extends SalonEvent{}

class SelectSalon extends SalonEvent{
  final Salon salon;

  SelectSalon({required this.salon});
}