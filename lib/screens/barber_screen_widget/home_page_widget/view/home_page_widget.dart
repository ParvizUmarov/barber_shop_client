import 'dart:developer';

import 'package:barber_shop/screens/barber_screen_widget/home_page_widget/bloc/barber_order_bloc/barber_order_bloc.dart';
import 'package:barber_shop/screens/barber_screen_widget/home_page_widget/bloc/barber_order_bloc/barber_order_event.dart';
import 'package:barber_shop/screens/barber_screen_widget/home_page_widget/bloc/barber_order_bloc/barber_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/resources/resources.dart';
import '../../../../shared/theme/colors/Colors.dart';

class BarberHomePage extends StatefulWidget {
  const BarberHomePage({super.key});

  @override
  State<BarberHomePage> createState() => _BarberHomePageState();
}

class _BarberHomePageState extends State<BarberHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              children: [
                //_WeekCalendarWidget(),
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

class _TodayOrders extends StatefulWidget {
  const _TodayOrders({
    super.key,
  });

  @override
  State<_TodayOrders> createState() => _TodayOrdersState();
}

class _TodayOrdersState extends State<_TodayOrders> {

  @override
  void initState() {
    context.read<BarberReservedOrderBloc>().add(GetAllReservedOrder());
    super.initState();
  }

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
            BlocBuilder<BarberReservedOrderBloc, BarberOrderState>(
              builder: (context, state) {
                if(state is ProgressOrderState){
                  return Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
                }else if(state is SuccessOrderState){
                  final model = state.orders;
                  if(model.isEmpty){
                    return Center(child: Text("Пока нету заказов"),);
                  }else{
                    return Container(
                      height: model.length * 60,
                      child: ListView.separated(
                          itemBuilder: (context, index){
                            log('order: ${state.orders.first}');
                            final order = model[index];
                            return _OrderContainer(
                                customerName: order.customerName,
                                customerPhone: order.customerPhone,
                                timeOfOrders: '${order.time.hour}:${order.time.minute}');
                          },
                          separatorBuilder: (context, index){
                            return SizedBox(height: 10,);
                          },
                          itemCount: model.length),
                    );
                  }
                }else{
                  return Center(child: Text('Упс что то пошло не так'),);
                }

              }
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

class _OrderContainer extends StatelessWidget {
  final String customerName;
  final String customerPhone;
  final String timeOfOrders;

  const _OrderContainer({
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

// class _WeekCalendarWidget extends StatefulWidget {
//   const _WeekCalendarWidget({
//     super.key,
//   });
//
//   @override
//   State<_WeekCalendarWidget> createState() => _WeekCalendarWidgetState();
// }
//
// class _WeekCalendarWidgetState extends State<_WeekCalendarWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final dateColor = Theme.of(context).brightness == Brightness.light
//         ? AppColors.mainColor
//         : Colors.white;
//     final pressedDateStyle = Theme.of(context).brightness == Brightness.light
//         ? Colors.black
//         : Colors.white;
//
//     return Container(
//       width: double.infinity,
//       height: 130,
//       decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.primary,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black38)]),
//       child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//           child: CalendarWeek(
//               minDate: DateTime.now().add(Duration(days: -365)),
//               maxDate: DateTime.now().add(Duration(days: 365)),
//               // monthViewBuilder: (DateTime time) => Align(
//               //       alignment: FractionalOffset.center,
//               //       child: Container(
//               //         margin: const EdgeInsets.symmetric(vertical: 4),
//               //         child: Text(
//               //           DateFormat.yMMMM().format(time),
//               //           overflow: TextOverflow.ellipsis,
//               //           textAlign: TextAlign.center,
//               //           style: TextStyle(
//               //               color: dateColor,
//               //               fontWeight: FontWeight.bold,
//               //               fontSize: 16),
//               //         ),
//               //       ),
//               //     ),
//               todayBackgroundColor: AppColors.mainColor,
//               todayDateStyle:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               pressedDateBackgroundColor:
//                   Theme.of(context).colorScheme.secondary,
//               pressedDateStyle: TextStyle(color: pressedDateStyle),
//               backgroundColor: Colors.transparent,
//               height: 100,
//               showMonth: true,
//               dateStyle: TextStyle(color: dateColor),
//               dayOfWeekStyle: TextStyle(color: dateColor))),
//     );
//   }
// }
