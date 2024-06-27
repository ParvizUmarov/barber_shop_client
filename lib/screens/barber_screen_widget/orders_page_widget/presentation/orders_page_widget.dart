import 'dart:developer';

import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/bloc/barber_orders_bloc/barber_orders_bloc.dart';
import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/bloc/barber_orders_bloc/barber_orders_event.dart';
import 'package:barber_shop/screens/barber_screen_widget/orders_page_widget/bloc/barber_orders_bloc/barber_orders_state.dart';
import 'package:barber_shop/shared/data/entity/order_info.dart';
import 'package:barber_shop/shared/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/theme/colors/Colors.dart';

Widget makeBarberOrdersPage(){
  return BlocProvider<BarberOrdersBloc>(
      create: (context) => BarberOrdersBloc(),
      child: BarberOrdersPage());
}

class BarberOrdersPage extends StatefulWidget {

  const BarberOrdersPage({super.key});

  @override
  State<BarberOrdersPage> createState() => _BarberOrdersPageState();
}

class _BarberOrdersPageState extends State<BarberOrdersPage> {
  
  @override
  void initState() {
    context.read<BarberOrdersBloc>().add(GetBarberOrder());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberOrdersBloc, BarberOrdersState>(
      builder: (context, state) {
        log('state: $state');
        if(state is BarberOrdersProgressState){
          return Center(child: CircularProgressIndicator(color: AppColors.mainColor,));
        }else if(state is BarberOrdersSuccessState){
          final model = state.barberOrders;
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
        }else {
          return Center(child: Text('Заказов нету'),);
        }
      }
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
                              text: 'Стрижка',),
                            _TextWidget(
                              title: 'Стоимость услуг',
                              text: '30 смн',),
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

