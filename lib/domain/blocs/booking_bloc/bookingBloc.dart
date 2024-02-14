
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

abstract class BookingEvent{}

class BookingAddEvent extends BookingEvent{}
class NotBookingEvent extends BookingEvent{}
class BookingDeleteEvent extends BookingEvent{}
class BookingChangeEvent extends BookingEvent{}


class BookingBloc extends Bloc<BookingEvent, BookingState>{
  BookingBloc(super.initialState){
    on<BookingEvent>((event, emit) async {
      if(event is NotBookingEvent){
        await onNotBookingEvent(event, emit);
      }else if(event is BookingAddEvent){
        await onBookingAddEvent(event, emit);
      }else if(event is BookingDeleteEvent){
        await onBookingDeleteEvent(event, emit);
      }else if(event is BookingChangeEvent){
        await onBookingChangeEvent(event, emit);
      }
      
    }, transformer: sequential());
    add(NotBookingEvent());
  }
}

Future<void> onNotBookingEvent(
    NotBookingEvent event, Emitter<BookingState> emit) async {

}

Future<void> onBookingAddEvent(
    BookingAddEvent event, Emitter<BookingState> emit) async {

}
Future<void> onBookingDeleteEvent(
    BookingDeleteEvent event, Emitter<BookingState> emit) async {

}
Future<void> onBookingChangeEvent(
    BookingChangeEvent event, Emitter<BookingState> emit) async {

}



abstract class BookingState{}

class BookingAddState extends BookingState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingAddState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookingNotCompleteState extends BookingState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingNotCompleteState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookingCompleteState extends BookingState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingCompleteState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class BookingDeleteState extends BookingState{

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingDeleteState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
