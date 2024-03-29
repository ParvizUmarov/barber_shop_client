import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../domain/blocs/booking_bloc.dart';
import '../home_page_widget/booking.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final model = context.read<BookingBloc>();

        return Center(
          child: Column(
            children: [
              Text('$state'),
              Text('${model.state.bookings.length}'),
              Text('${model.state.bookings}'),
            ],
          ),
        );

        if (model.state.bookings.isNotEmpty) {
          return Text('${model.state}');
            // ListView.builder(
            //   itemCount: model.state.bookings.length,
            //   itemBuilder: (context, index) {
            //     return Center(
            //         child: _BookingTile(booking: model.state.bookings[index]));
            //   });
        } else {
          return Center(
            child: Text(
              'Пусто!',
              style: TextStyle(color: Colors.grey),
            ),
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
