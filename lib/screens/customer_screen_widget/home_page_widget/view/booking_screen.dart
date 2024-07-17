import 'package:barber_shop/shared/data/entity/barber_info.dart';
import 'package:barber_shop/shared/general_blocs/booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/colors/Colors.dart';
import 'booking.dart';

class BookingScreen extends StatelessWidget {
  final BarberInfo barberInfo;

  const BookingScreen(
      {super.key,
        required this.barberInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(18)),
              child: const BackButton(
                color: Colors.white,
              )),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Image.network(barberInfo.salonImages),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                _BarberName(masterName: barberInfo.name, isOpened: true),
                _BarberRating(rating: 3),
                SizedBox(height: 20),
                _BarberScheduleAndLocation(
                    barberSchedule: '8:00 - 18:00', locations: barberInfo.salonAddress),
                SizedBox(height: 10),
                _Services(cost: barberInfo.servicePrice),
                SizedBox(height: 10),
                _OrderButton(
                  barberInfo: barberInfo
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderButton extends StatelessWidget {
   final BarberInfo barberInfo;

  const _OrderButton({
    super.key, required this.barberInfo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if(state is BookingSuccessState){
          context.pop();
        }
      },
        builder: (context, state) {
      final model = context.read<BookingBloc>();

      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.mainColor),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)))),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    content: Text(
                        'Общая сумма услуги ${barberInfo.servicePrice} смн.\nЗаписаться к парикмахеру?'),
                    actions: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Нет'),
                      ),
                      MaterialButton(
                        onPressed: () {
                          model.add(
                            BookingAddEvent(barberInfo: barberInfo
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text('Да'),
                      )
                    ],
                  ));
        },
        child: state is BookingProgressState
            ? Center(child: CircularProgressIndicator(color: Colors.white,),)
            : Text(
          'Записаться',
          style: TextStyle(color: Colors.white),
        ),
      );
    });
  }
}

class _Services extends StatelessWidget {
  const _Services({
    super.key,
    required this.cost,
  });

  final int cost;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _BarberServices(
            cost: cost,
            nameOfServices: 'Стрижка',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey[350]
                  : Colors.white,
            ),
          ),
          _BarberServices(
            cost: cost,
            nameOfServices: 'Бриться',
          ),
        ],
      ),
    );
  }
}

class _BarberScheduleAndLocation extends StatelessWidget {
  const _BarberScheduleAndLocation({
    super.key,
    required this.barberSchedule,
    required this.locations,
  });

  final String barberSchedule;
  final String locations;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(
            'График работы: $barberSchedule',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text('Адрес: $locations'),
        ],
      ),
    );
  }
}

class _BarberServices extends StatefulWidget {
  const _BarberServices({
    super.key,
    required this.cost,
    required this.nameOfServices,
  });

  final String nameOfServices;
  final int cost;

  @override
  State<_BarberServices> createState() => _BarberServicesState();
}

class _BarberServicesState extends State<_BarberServices> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.nameOfServices,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text('${widget.cost} c'),
      trailing: Switch(
        activeColor: Colors.white,
        activeTrackColor: AppColors.mainColor,
        inactiveTrackColor: Colors.white,
        inactiveThumbColor: AppColors.mainColor,
        value: isSelected,
        onChanged: (bool value) {
          setState(() {
            isSelected = value;
          });
        },
      ),
    );
  }
}

class _BarberRating extends StatelessWidget {
  const _BarberRating({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$rating'),
        SizedBox(
          width: 10,
        ),
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 20.0,
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}

class _BarberName extends StatelessWidget {
  const _BarberName({
    super.key,
    required this.masterName,
    required this.isOpened,
  });

  final String masterName;
  final bool isOpened;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          masterName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isOpened == true ? Colors.green : Colors.red,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Center(
              child: Text(
                isOpened == true ? 'Открыто' : 'Закрыто',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
