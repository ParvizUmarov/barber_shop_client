import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/resources/resources.dart';
import '../../../../shared/theme/colors/Colors.dart';

class BarberHomePage extends StatelessWidget {
  const BarberHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
                _WeekCalendarWidget(),
                SizedBox(height: 20),
                _TodayOrders(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TodayOrders extends StatelessWidget {
  const _TodayOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.mainListColors,
        ),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black38)],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Заказы на сегодня',
                style: TextStyle(
                    fontSize: 18, color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            _Customer(
              customerName: 'Парвиз',
              customerPhone: '928466000',
              timeOfOrders: '10:30',
            ),
            _Customer(
              customerName: 'Фирдаус',
              customerPhone: '928466000',
              timeOfOrders: '11:30',
            ),
            _Customer(
              customerName: 'Абдулатиф',
              customerPhone: '928466000',
              timeOfOrders: '12:30',
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                  onPressed: (){},
                  child: Text(
                    'Всего заказов: 4',
                    style: TextStyle(
                      color: AppColors.mainColor
                    )
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class _Customer extends StatelessWidget {
  final String customerName;
  final String customerPhone;
  final String timeOfOrders;

  const _Customer({
    super.key,
    required this.customerName,
    required this.customerPhone,
    required this.timeOfOrders,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(radius: 20, child: Image.asset(Images.userAvatar)),
      title: Text(
        customerName,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      subtitle: Text(
        customerPhone,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Text(
        timeOfOrders,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

class _WeekCalendarWidget extends StatefulWidget {
  const _WeekCalendarWidget({
    super.key,
  });

  @override
  State<_WeekCalendarWidget> createState() => _WeekCalendarWidgetState();
}

class _WeekCalendarWidgetState extends State<_WeekCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    final dateColor = Theme.of(context).brightness == Brightness.light
        ? AppColors.mainColor
        : Colors.white;
    final pressedDateStyle = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black38)]),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: CalendarWeek(
              minDate: DateTime.now().add(Duration(days: -365)),
              maxDate: DateTime.now().add(Duration(days: 365)),
              monthViewBuilder: (DateTime time) => Align(
                    alignment: FractionalOffset.center,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        DateFormat.yMMMM().format(time),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: dateColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
              todayBackgroundColor: AppColors.mainColor,
              todayDateStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              pressedDateBackgroundColor:
                  Theme.of(context).colorScheme.secondary,
              pressedDateStyle: TextStyle(color: pressedDateStyle),
              backgroundColor: Colors.transparent,
              height: 100,
              showMonth: true,
              dateStyle: TextStyle(color: dateColor),
              dayOfWeekStyle: TextStyle(color: dateColor))),
    );
  }
}
