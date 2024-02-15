import 'package:equatable/equatable.dart';

class Booking {
  final String barberName;
  final String services;
  final int totalAmount;

  Booking(
      {required this.barberName,
      required this.services,
      required this.totalAmount});

  @override
  String toString() {
    return 'Booking{barberName: $barberName, services: $services, totalAmount: $totalAmount}';
  }
}
