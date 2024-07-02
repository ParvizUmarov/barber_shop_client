
import 'dart:convert';
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/customer.dart';
import 'package:barber_shop/shared/data/entity/user.dart';
import 'package:barber_shop/shared/network/network.dart';
import 'package:http/http.dart' as http;
import '../../data/repository/barber_repository.dart';
import 'barber_repository.dart';

class CustomersRepository{

  Future<ResponseFromRequest> login(String mail, String password) async {
    try{
      final response = await http.get(Uri.parse('$baseURL/customer/login/$mail/$password'),);
      final data = jsonDecode(response.body);
      log('response from customer repository: $data');
      Users user = Users.fromJson(data);
      return ResponseFromRequest(response: user);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }

  Future<ResponseFromRequest> getProfileInfo(String token) async {
    try{
      final response = await http.post(
        Uri.parse('$baseURL/customer/profile'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token
        }
      );
      final data = jsonDecode(response.body);
      log('response from customer repository (getProfileInfo): $data');
      Customer customer = Customer.fromJson(data);
      return ResponseFromRequest(response: customer);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }

  Future<ResponseFromRequest> logout(String token) async {
    try{
      final response = await http.get(
        Uri.parse('$baseURL/customer/logout'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": token
          });
      log('response status (customer logout): ${response.statusCode}');
      return ResponseFromRequest(response: response.statusCode);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }

  Future<ResponseFromRequest> register(Customer custome) async {
    try{

      var body = {
        "id": null,
        "name": custome.name,
        "surname": custome.surname,
        "birthday": custome.birthday,
        "phone": custome.phone,
        "mail": custome.mail,
        "password": custome.password,
        "authState": custome.authState,
        "token": ""
      };


      final response = await http.post(
          Uri.parse('$baseURL/customer/register'),
          headers: headers,
          body: json.encode(body)
      );
      final data = jsonDecode(response.body);
      log('response from customer repository (register): $data');
      Users user = Users.fromJson(data);
      return ResponseFromRequest(response: user);
    }catch (e){
      log('register customer error ${e.toString()}');
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }



}
