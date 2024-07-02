
import 'dart:convert';
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/barber_info.dart';
import 'package:barber_shop/shared/data/entity/user.dart';
import 'package:barber_shop/shared/data/repository/barber_repository.dart';
import 'package:barber_shop/shared/data/entity/order_info.dart';
import 'package:barber_shop/shared/network/network.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class OrderRepository{

  Future<ResponseFromRequest> getAllOrderOfBarber(String token) async {
    try{
      List<List<OrderInfo>> allOrders = [];
      var response = await http.get(
        Uri.parse('$baseURL/order/barber/all_orders'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token
        },
      );


      final data = json.decode(utf8.decode(response.bodyBytes)) as List;

      log('response from all barber orders: $data');

      var doneList = (data[0] as List)
          .map((orderJson) => OrderInfo.fromJson(orderJson))
          .toList();

      var reservedList = (data[1] as List)
          .map((orderJson) => OrderInfo.fromJson(orderJson))
          .toList();

      var canceledList = (data[2] as List)
          .map((orderJson) => OrderInfo.fromJson(orderJson))
          .toList();

      log('first $doneList');
      log('second: $reservedList');
      log('third: $canceledList');

      allOrders.add(doneList);
      allOrders.add(reservedList);
      allOrders.add(canceledList);

      return ResponseFromRequest(response: allOrders);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }
  }

  Future<ResponseFromRequest> getBarberReservedOrder(String token) async {
    try{
      var response = await http.get(
        Uri.parse('$baseURL/order/barber/reserved_order'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token
        },
      );

      final data = json.decode(utf8.decode(response.bodyBytes)) as List;

      List<OrderInfo> orders = data
          .map((orderJson) => OrderInfo.fromJson(orderJson))
          .toList();

      log('response from all barber reserved orders: $orders');

      return ResponseFromRequest(response: orders);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }
  }

  Future<ResponseFromRequest> getOrderOfCustomer(String token) async {
    try{
      var response = await http.get(
        Uri.parse('$baseURL/order/customer'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token
        },
      );

      final data = json.decode(utf8.decode(response.bodyBytes)) as List;

      List<OrderInfo> orders = data
          .map((orderJson) => OrderInfo.fromJson(orderJson))
          .toList();

      log('response from all customer orders: $orders');

      return ResponseFromRequest(response: orders);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }
  }

  Future<ResponseFromRequest> getCustomerReservedOrder(String token) async {
    try{
      var response = await http.get(
        Uri.parse('$baseURL/order/customer/reserved'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token
        },
      );

      final data = json.decode(utf8.decode(response.bodyBytes)) as List;

      List<OrderInfo> orders = data
          .map((orderJson) => OrderInfo.fromJson(orderJson))
          .toList();

      log('response customers reserved orders: $orders');

      return ResponseFromRequest(response: orders);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }
  }

  Future<ResponseFromRequest> createOrder(Users users, BarberInfo barberInfo) async {
    try{
      log('creating in progress');
      var data = {
        "customerId": users.uid,
        "barberId": barberInfo.id,
        "status": "RESERVED",
        "time": Timestamp.now().seconds,
        "serviceId": barberInfo.serviceId
      };

      var body = jsonEncode(data);

      log('data is readyyy!!');

      var response = await http.post(
        Uri.parse('$baseURL/order/customer/create_order'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": users.token
        },
        body: body,
      );

      log('status code for create orders: ${response.statusCode}');

      return ResponseFromRequest(response: response.statusCode);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }
  }




}