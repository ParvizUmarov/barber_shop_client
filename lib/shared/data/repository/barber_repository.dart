
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:barber_shop/shared/data/entity/barber.dart';
import 'package:barber_shop/shared/data/entity/barber_info.dart';
import 'package:barber_shop/shared/data/entity/user.dart';
import 'package:barber_shop/shared/network/network.dart';
import 'package:http/http.dart' as http;


class BarbersRepository{

  Future<ResponseFromRequest> getAllBarbersInfo(String mail, String token) async {
    try{
      var response = await http.get(
        Uri.parse('$baseURL/barber/allInfo'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token
        },
      );

      final data = json.decode(utf8.decode(response.bodyBytes)) as List;
      log('response from all barber info: $data');

      List<BarberInfo> barberInfo = data
          .map((barberJson) => BarberInfo.fromJson(barberJson))
          .toList();

      return ResponseFromRequest(response: barberInfo);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }

  Future<ResponseFromRequest> getBarberInfo(String mail, String token) async {
    try{
      var response = await http.post(
        Uri.parse('$baseURL/barber/profile/$mail'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token
        },
      );

      final data = jsonDecode(response.body);
      log('response from barberByIdRepository: $data');

      Barber barber = Barber.fromJson(data);

      return ResponseFromRequest(response: barber);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }

  Future<ResponseFromRequest> login(String mail, String password) async {
    try{
      final response = await http.get(Uri.parse('$baseURL/barber/login/$mail/$password'));
      log('response status: ${response.statusCode}');
      final data = await jsonDecode(response.body);
      log('response from barberByMailRepository: $data');

      Users users = Users.fromJson(data);

      return ResponseFromRequest(response: users);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }

  Future<ResponseFromRequest> logout(String mail) async {
    try{
      final response = await http.get(Uri.parse('$baseURL/barber/logout/$mail'));
      log('response status: ${response.statusCode}');
      final data = await jsonDecode(response.body);
      log('response from barberByMailRepository: $data');
      return ResponseFromRequest(response: data);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }


  Future<ResponseFromRequest> getByMail(String mail) async {
    try{
      final response = await http.get(Uri.parse('$baseURL/barber/mail/$mail'));
      log('response status: ${response.statusCode}');
      final data = await jsonDecode(response.body);
      log('response from barberByMailRepository: $data');

      Barber barber = Barber.fromJson(data);

      return ResponseFromRequest(response: barber);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }

  Future<ResponseFromRequest> register(Barber barber) async {
    try{

      Barber newBarber = Barber(
          name: barber.name,
          surname: barber.surname,
          birthday: barber.birthday,
          password: barber.password,
          phone: barber.phone,
          mail: barber.mail,
          workExperience: barber.workExperience,
          authState: barber.authState,
          id: barber.id
      );

      final body = json.encode(newBarber);

      final response = await http.post(
          Uri.parse('$baseURL/barber/register'),
          headers: headers,
          body: body
      );

      final data = jsonDecode(response.body);
      log('response from barber repository (register): $data');
      Users user = Users.fromJson(data);

      log('barberRegister request status: ${response.statusCode}');

      return ResponseFromRequest(response: user);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }
  }

  Future<ResponseFromRequest> updateBarberData (Barber barber) async {
    try{

      Barber updateBarber = Barber(
          name: barber.name,
          surname: barber.surname,
          birthday: barber.birthday,
          password: barber.password,
          phone: barber.phone,
          mail: barber.mail,
          workExperience: barber.workExperience,
          authState: barber.authState,
          id: barber.id
      );

      final body = json.encode(updateBarber);

      final response = await http.put(
          Uri.parse('$baseURL/barber'),
          headers: headers,
          body: body
      );

      log('barberUpdate request status: ${response.statusCode}');

      return ResponseFromRequest(response: response);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }
  }
}

class ResponseFromRequest {
  final dynamic response;
  final String? errorMessage;

  ResponseFromRequest({this.response, this.errorMessage});
}