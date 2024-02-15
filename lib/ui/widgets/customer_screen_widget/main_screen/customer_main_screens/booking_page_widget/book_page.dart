import 'package:barber_shop/ui/widgets/customer_screen_widget/main_screen/customer_main_screens/home_page_widget/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../domain/blocs/booking_bloc/booking_bloc.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final list = context.watch<BookingBloc>();

        if(state is BookingUpdateState && state.bookings.isNotEmpty){
          final bookings = list.state.bookings;
          return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index){
                final booking = bookings[index];
                return Center(child: _BookingTile(booking: booking));
              });

        }else{
          return Center(
            child: Text('Пусто!', style: TextStyle(color: Colors.grey),),
          );
        }
      },
    );
  }
}

class _BookingTile extends StatelessWidget {
  const _BookingTile({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(booking.barberName),
        Text(booking.services),
        Text('${booking.totalAmount}'),

      ],
    );
  }
}

