import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String barberName;
  final String services;
  final int totalAmount;

  Booking(
      {required this.barberName,
      required this.services,
      required this.totalAmount});


  @override
  List<Object?> get props => [barberName, services, totalAmount];
}
