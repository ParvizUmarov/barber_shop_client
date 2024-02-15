
import 'package:barber_shop/ui/widgets/customer_screen_widget/main_screen/customer_main_screens/home_page_widget/booking.dart';
import 'package:bloc/bloc.dart';


class CubitBooking extends Cubit<BookingState>{
  CubitBooking(super.initialState);

  void add(Booking booking) {
    emit(BookingAddState(booking: booking));
  }


}

abstract class BookingState {
  Booking booking;
  
  BookingState({required this.booking});

}

class BookingAddState extends BookingState {
  
  BookingAddState({required super.booking});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BookingAddState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookingGetState extends BookingState {
  
  BookingGetState({required super.booking});
  
  

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BookingAddState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookingNotCompleteState extends BookingState {
  BookingNotCompleteState({required super.booking});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BookingNotCompleteState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookingCompleteState extends BookingState {
  BookingCompleteState({required super.booking});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BookingCompleteState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookingDeleteState extends BookingState {
  BookingDeleteState({required super.booking});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BookingDeleteState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookingUnknownState extends BookingState {
  BookingUnknownState({required super.booking});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BookingUnknownState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}