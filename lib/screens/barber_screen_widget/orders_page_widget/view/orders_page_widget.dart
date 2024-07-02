import 'dart:developer';

import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/bloc/barber_orders_bloc/barber_orders_bloc.dart';
import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/bloc/barber_orders_bloc/barber_orders_event.dart';
import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/bloc/barber_orders_bloc/barber_orders_state.dart';
import 'package:barber_shop/shared/data/entity/order_info.dart';
import 'package:barber_shop/shared/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/colors/Colors.dart';

class BarberOrdersPage extends StatefulWidget {

  const BarberOrdersPage({super.key});

  @override
  State<BarberOrdersPage> createState() => _BarberOrdersPageState();
}

class _BarberOrdersPageState extends State<BarberOrdersPage> {
  
  @override
  void initState() {
    log('init screen barber order');
    context.read<BarberAllOrdersBloc>().add(GetBarberOrder());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: AppColors.mainColor,
            dividerColor: Colors.white,
            labelColor: AppColors.mainColor,
            tabs: [
              Tab(
                text: 'Забронированый',
              ),
              Tab(
                text: 'Отменный',
              ),
              Tab(
                text: 'Завершенный',
              ),
            ],
          ),
        ),
        body: BlocBuilder<BarberAllOrdersBloc, BarberOrdersState>(
          builder: (context, state) {
            if(state is BarberOrdersProgressState){
              return Center(child: CircularProgressIndicator(color: AppColors.mainColor,));
            }else if(state is BarberOrdersSuccessState){
              final doneResult = state.doneOrders;
              final reservedResult = state.reservedOrders;
              final cancelResult = state.canceledOrders;

              return TabBarView(
                children: [
                  Material(child: _ReservedOrderPage(orders: reservedResult),),
                  Material(child: _CancelOrderPage(orders: cancelResult)),
                  Material(child: _DoneOrderPage(orders: doneResult)),
                ],
              );
            }else {
              return Center(child: Text('Заказов нету'),);
            }
          }
        ),
      ),
    );
  }
}

class _DoneOrderPage extends StatefulWidget {
  final List<OrderInfo> orders;
  const _DoneOrderPage({super.key, required this.orders});

  @override
  State<_DoneOrderPage> createState() => _DoneOrderPageState();
}

class _DoneOrderPageState extends State<_DoneOrderPage> {
  @override
  Widget build(BuildContext context) {
    final model = widget.orders;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 600,
        child: model.isEmpty
            ?  Center(child: Text('Пока заказов нет'),)
            : ListView.separated(
            itemBuilder: (context, index){
              return _Orders(orderInfo: model[index]);
            },
            separatorBuilder: (context, index){
              return SizedBox(height: 10);
            },
            itemCount: model.length),
      ),
    );
  }
}

class _CancelOrderPage extends StatefulWidget {
  final List<OrderInfo> orders;
  const _CancelOrderPage({super.key, required this.orders});

  @override
  State<_CancelOrderPage> createState() => _CancelOrderPageState();
}

class _CancelOrderPageState extends State<_CancelOrderPage> {
  @override
  Widget build(BuildContext context) {
    final model = widget.orders;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 600,
        child: model.isEmpty
            ?  Center(child: Text('Пока заказов нет'),)
            : ListView.separated(
            itemBuilder: (context, index){
              return _Orders(orderInfo: model[index]);
            },
            separatorBuilder: (context, index){
              return SizedBox(height: 10);
            },
            itemCount: model.length),
      ),
    );
  }
}

class _ReservedOrderPage extends StatefulWidget {
  final List<OrderInfo> orders;
  const _ReservedOrderPage({super.key, required this.orders});

  @override
  State<_ReservedOrderPage> createState() => _ReservedOrderPageState();
}

class _ReservedOrderPageState extends State<_ReservedOrderPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final model = widget.orders;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 600,
        child: model.isEmpty
            ?  Center(child: Text('Пока заказов нет'),)
            : ListView.separated(
            itemBuilder: (context, index){
              return _Orders(orderInfo: model[index]);
            },
            separatorBuilder: (context, index){
              return SizedBox(height: 10);
            },
            itemCount: model.length),
      ),
    );
  }
}




class _Orders extends StatelessWidget {
  final OrderInfo orderInfo;

  const _Orders({
    super.key,
    required this.orderInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                formattedDateTime(orderInfo.time),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.mainListColors,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 30,
                          child: Image.asset(Images.userAvatar),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            _TextWidget(
                              title: 'Имя',
                              text: orderInfo.customerName,)
                            ,_TextWidget(
                              title: 'Забронирован',
                              text: formattedDateTime(orderInfo.time),),
                            _TextWidget(
                              title: 'Услуги',
                              text: orderInfo.serviceName,),
                            _TextWidget(
                              title: 'Стоимость услуг',
                              text: "${orderInfo.servicePrice.toString()} смн",),
                            Row(
                              children: [
                                IconButton.filled(
                                    onPressed: (){},
                                    icon: Icon(Icons.phone,
                                    color: AppColors.mainColor),
                                ),
                                IconButton.filled(
                                    onPressed: (){},
                                    icon: Icon(Icons.chat_outlined,
                                          color: AppColors.mainColor,),
                                ),

                              ],
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String formattedDateTime(DateTime time){
    return "${time.hour}:${time.minute}";
  }

}

class _TextWidget extends StatelessWidget {
  final String title;
  final String text;
  const _TextWidget({
    super.key,
    required this.text,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
        child: Row(
          children: [
            Text('$title: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            Text(text,
              style: TextStyle(
                fontSize: 16,
                  color: Colors.white
              ),
            ),
          ],
        )
    );
  }
}

