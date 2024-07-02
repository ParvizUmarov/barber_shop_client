import 'dart:developer';

import 'package:barber_shop/screens/customer_screen_widget/customer_history_orders_page/bloc/customer_history_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_history_orders_page/bloc/customer_history_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/customer_history_orders_page/bloc/customer_history_state.dart';
import 'package:barber_shop/shared/data/entity/order_info.dart';
import 'package:barber_shop/shared/theme/colors/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CustomerHistoryPage extends StatefulWidget {
  const CustomerHistoryPage({super.key});

  @override
  State<CustomerHistoryPage> createState() => _CustomerHistoryPageState();
}

class _CustomerHistoryPageState extends State<CustomerHistoryPage> {
  @override
  void initState() {
    context.read<CustomerHistoryBloc>().add(GetAllCustomerOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CustomerHistoryBloc, CustomerHistoryState>(
          builder: (context, state) {
        if (state is HistoryPageProgress) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.mainColor,
            ),
          );
        } else if (state is HistoryPageSuccess) {
          final model = state.orders;
          if (model.isEmpty) {
            return Center(child: Text('Пусто'));
          } else {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return _HistoryContainer(orderInfo: model[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
                itemCount: model.length);
          }
        } else {
          return Center(child: Text('Пусто'));
        }
      }),
    );
  }
}

class _HistoryContainer extends StatelessWidget {
  final OrderInfo orderInfo;

  const _HistoryContainer({super.key, required this.orderInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Image.asset("assets/images/user_avatar.png"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          'Парикмахер: ${orderInfo.barberName}',
                          style: mainText(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Услуга: ${orderInfo.serviceName}',
                          style: secondaryText(),
                        ),
                        Text(
                          'Номер телефона: ${orderInfo.barberPhone}',
                          style: secondaryText(),
                        ),
                        Text(
                          'Цена: ${orderInfo.servicePrice}',
                          style: secondaryText(),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Забронированная дата:',
                          style: secondaryText(),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          formattedDateTime(orderInfo.time),
                          style: mainText(),
                        ),
                      ],
                    ),
                    Spacer(),
                    _OrderStatus(status: orderInfo.status,),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  String formattedDateTime(DateTime time) {
    return DateFormat('dd MMMM yyyy, hh:mm aaa').format(time);
  }

  TextStyle secondaryText() {
    return TextStyle(color: Colors.grey, fontSize: 14);
  }

  TextStyle mainText() {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  }
}

class _OrderStatus extends StatelessWidget {
  final String status;
  const _OrderStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    log('status: $status');
    return Container(
      width: 90,
      height: 30,
      decoration: BoxDecoration(
          color: getContainerColor(status),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Center(child: Text(status, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
    );
  }

  Color getContainerColor(String status){
    if(status == OrderStatus.done){
      return Colors.green;
    }else if(status == OrderStatus.reserved){
      return Colors.amber;
    }else if(status == OrderStatus.changed){
      return Colors.blue;
    }else {
      return Colors.red;
    }
  }

}

