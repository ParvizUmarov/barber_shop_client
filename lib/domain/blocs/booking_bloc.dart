import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import '../../widgets/ui/customer_screen_widget/home_page_widget/booking.dart';


abstract class BookingEvent extends Equatable{
  final Booking booking;

  BookingEvent({required this.booking});
}

class BookingInitialEvent extends BookingEvent{
  BookingInitialEvent({required super.booking});

  @override
  List<Object?> get props => [booking];

}

class BookingAddEvent extends BookingEvent {
  BookingAddEvent({required super.booking});

  @override
  List<Object?> get props => [booking];
  
}

class BookingDeleteEvent extends BookingEvent {
  BookingDeleteEvent({required super.booking});

  @override
  List<Object?> get props => [booking];
}

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitialState(bookings: [])) {

    List<Booking> bookings = [];

    on<BookingEvent>((event, emit) async {

      if (event is BookingInitialEvent) {
        await _onBookingInitialEvent(event, emit, bookings);
      } else if (event is BookingAddEvent) {
        await _onBookingAddEvent(event, emit, bookings);
      } else if (event is BookingDeleteEvent) {
        await _onBookingDeleteEvent(event, emit);
      }
    }, transformer: sequential());

    add(BookingInitialEvent(booking: Booking(
        barberName: '',
        services: '',
        totalAmount: 0)));
  }
  
  Future<void> _onBookingAddEvent(BookingAddEvent event,
      Emitter<BookingState> emit,
      List<Booking> bookings) async {
    List<Booking> newState = [];

    Booking newBooking = Booking(
        barberName: event.booking.barberName,
        services: event.booking.services,
        totalAmount: event.booking.totalAmount);

    newState.add(newBooking);
    emit(BookingAddState(bookings: newState));
    log('BookingAddState EMITTED --> ${event.booking.toString()}');
  }

  Future<void> _onBookingInitialEvent(
      BookingInitialEvent event,
      Emitter<BookingState> emit,
      List<Booking> bookings) async {
    bookings = state.bookings;
    emit(BookingUpdateState(bookings: state.bookings));
    log('BookingUpdateState EMITTED --> ${event.booking.toString()}');

  }

  Future<void> _onBookingDeleteEvent(BookingDeleteEvent event,
      Emitter<BookingState> emit) async {
      // state.bookings.remove(event.booking);
      // emit(BookingUpdateState(bookings: state.bookings));
  }

  // Future<void> _onBookingUpdateEvent(BookingUpdateEvent event,
  //     Emitter<BookingState> emit)  async {
    // for(int i = 0; i < state.bookings.length; i++){
    //     state.bookings[i] = event.booking;
    // }
    // emit(BookingUpdateState(bookings: state.bookings));
  //}
  
  
}


abstract class BookingState extends Equatable {
  final List<Booking> bookings;
  
  BookingState({required this.bookings});
}

class BookingAddState extends BookingState {
  BookingAddState({required super.bookings});

  @override
  List<Object?> get props => [super.bookings];
}

class BookingUpdateState extends BookingState {
  BookingUpdateState({required super.bookings});

  @override
  List<Object?> get props => super.bookings;
}

class BookingDeleteState extends BookingState {
  BookingDeleteState({required super.bookings});

  @override
  List<Object?> get props => [super.bookings];

}

class BookingInitialState extends BookingState {
  BookingInitialState({required super.bookings});

  @override
  List<Object?> get props => super.bookings;

}
