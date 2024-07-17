import 'dart:convert';
import 'dart:developer';
import 'package:barber_shop/screens/customer_screen_widget/booking_page_widget/bloc/customer_order_bloc/customer_order_bloc.dart';
import 'package:barber_shop/screens/customer_screen_widget/booking_page_widget/bloc/customer_order_bloc/customer_order_event.dart';
import 'package:barber_shop/screens/customer_screen_widget/booking_page_widget/bloc/customer_order_bloc/customer_order_state.dart';
import 'package:barber_shop/shared/data/entity/order_info.dart';
import 'package:barber_shop/shared/general_blocs/booking_bloc.dart';
import 'package:barber_shop/shared/data/entity/barber.dart';
import 'package:barber_shop/shared/navigation/route_name.dart';
import 'package:barber_shop/shared/network/network.dart';
import 'package:barber_shop/shared/theme/colors/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  @override
  void initState() {
    context.read<CustomerOrderBloc>().add(GetReservedCustomerOrder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerOrderBloc, CustomerOrderState>(
      builder: (context, state) {
        if(state is CustomerProgressOrderState){
          return Center(child: CircularProgressIndicator(color: AppColors.mainColor,));
        }else if(state is CustomerSuccessOrderState){
          if(state.orders.isEmpty){
            return Center(
              child: Text('Пока у вас нету бранирование'),
            );
          }else{
            final model = state.orders;
            return ListView.separated(
                itemBuilder: (context, index){
                  return _BookingContainer(orderInfo: model[index],);
                },
                separatorBuilder: (context, index){
                  return SizedBox(height: 10,);
                },
                itemCount: model.length);
          }
        }else{
          return Center(
            child: Text('Упс что-то пошло не так!', style: TextStyle(color: Colors.red),),
          );
        }

      },
    );
  }
}

class _BookingContainer extends StatelessWidget {
  final OrderInfo orderInfo;
  const _BookingContainer({super.key, required this.orderInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(orderInfo.barberName),
              Text(orderInfo.barberPhone),
              //Text(orderInfo.status),
              Text(orderInfo.time.toString()),
              Text(orderInfo.serviceName),
              Text(orderInfo.servicePrice.toString()),
              _ContactWithBarberButtons(
                barberId: orderInfo.barberId,
                barberPhone: orderInfo.barberPhone,)
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactWithBarberButtons extends StatelessWidget {
  final int barberId;
  final String barberPhone;
  const _ContactWithBarberButtons({
    super.key, required this.barberId, required this.barberPhone});

  @override
  Widget build(BuildContext context) {

    void makePhoneCall(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ContactButtonWidget(
          onTap: () {
            launchUrlString("tel://$barberPhone");
          },
          btnTxt: 'Позвонить',
          iconData: Icons.phone),
        _ContactButtonWidget(
          onTap: () {
            context.go(Routes.customerChatPage);
          },
          btnTxt: 'Написать',
          iconData: Icons.chat)
      ],
    );
  }
}

class _ContactButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Function() onTap;
  final String btnTxt;
  const _ContactButtonWidget({
    super.key,
    required this.onTap,
    required this.btnTxt,
    required this.iconData});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          backgroundColor: AppColors.mainColor,
        ),
        onPressed: onTap,
        child: Row(
          children: [
            Icon(iconData, color: Colors.white,),
            SizedBox(width: 10,),
            Text(btnTxt, style: TextStyle(color: Colors.white),),
          ],
        ));
  }
}



