import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../ui/widgets/customer_screen_widget/main_screen/customer_main_screens/home_page_widget/booking.dart';

abstract class BookingEvent {
  final Booking booking;

  BookingEvent({required this.booking});
}

class BookingAddEvent extends BookingEvent {
  BookingAddEvent({required super.booking});
  
}

class NotBookingEvent extends BookingEvent {
  NotBookingEvent({required super.booking});
}

class BookingDeleteEvent extends BookingEvent {
  BookingDeleteEvent({required super.booking});
}

class BookingUpdateEvent extends BookingEvent {
  BookingUpdateEvent({required super.booking});
}

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc(BookingState initialState) : super(initialState) {

    on<NotBookingEvent>(_onNotBookingEvent);
    on<BookingAddEvent>(_onBookingAddEvent);
    on<BookingUpdateEvent>(_onBookingUpdateEvent);
    on<BookingDeleteEvent>(_onBookingDeleteEvent);

  }
  
  void _onBookingAddEvent(BookingAddEvent event,
      Emitter<BookingState> emit) {
    
    state.bookings.add(event.booking);
    log('ADDED');

    emit(BookingUpdateState(bookings: state.bookings));
  }

  void _onNotBookingEvent(NotBookingEvent event,
      Emitter<BookingState> emit) {

  }

  void _onBookingDeleteEvent(BookingDeleteEvent event,
      Emitter<BookingState> emit) {
      state.bookings.remove(event.booking);
      emit(BookingUpdateState(bookings: state.bookings));
  }

  void _onBookingUpdateEvent(BookingUpdateEvent event,
      Emitter<BookingState> emit)  {
    for(int i = 0; i < state.bookings.length; i++){
        state.bookings[i] = event.booking;
    }  
    emit(BookingUpdateState(bookings: state.bookings));
  }
  
  
}


abstract class BookingState {
  List<Booking> bookings;
  
  BookingState({required this.bookings});
}

class BookingAddState extends BookingState {
  BookingAddState({required super.bookings});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BookingAddState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookingUpdateState extends BookingState {
  BookingUpdateState({required super.bookings});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BookingAddState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookingDeleteState extends BookingState {
  BookingDeleteState({required super.bookings});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BookingDeleteState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookingInitialState extends BookingState {
  BookingInitialState({required super.bookings});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BookingInitialState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
