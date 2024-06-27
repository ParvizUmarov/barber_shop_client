import 'dart:async';
import 'dart:developer';
import 'package:barber_shop/screens/customer_screen_widget/home_page_widget/presentation/booking.dart';
import 'package:bloc/bloc.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingState(bookings: []));

  void add(Booking booking) {

    Booking newBooking =
        Booking(
            barberName: booking.props[0].toString(),
            services: booking.props[1].toString(),
            totalAmount: booking.props[2] as int);

    final List<Booking> newBookingList = [];
    newBookingList.add(newBooking);
    log('Service added');
    emit(state.copyWith(bookings: newBookingList));
    log('Service emitted');

    print('newBooking hashCode ${newBooking.hashCode}');
    print('booking hashCode ${booking.hashCode}');
  }
}

class BookingState {
  final List<Booking> bookings;

  BookingState({required this.bookings});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingState &&
          runtimeType == other.runtimeType &&
          bookings == other.bookings;

  @override
  int get hashCode => bookings.hashCode;

  BookingState copyWith({List<Booking>? bookings}) {
    return BookingState(bookings: bookings ?? this.bookings);
  }
}
