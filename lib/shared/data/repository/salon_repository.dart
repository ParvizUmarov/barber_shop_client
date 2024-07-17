
import 'dart:convert';
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/salon.dart';
import 'package:barber_shop/shared/data/repository/barber_repository.dart';
import 'package:barber_shop/shared/network/network.dart';
import 'package:http/http.dart' as http;

class SalonRepository{

  Future<ResponseFromRequest> getAllSalons() async{
    try{
      final response = await http.get(Uri.parse('$baseURL/salon'));
      log('Status code: ${response.statusCode}');
      final data = json.decode(utf8.decode(response.bodyBytes)) as List;


      List<Salon> salons = data
          .map((messageJson) => Salon.fromJson(messageJson))
          .toList();

      log('response from salonRepository: $salons');

      return ResponseFromRequest(response: salons);
    }on http.ClientException {
      log('Что то пошло не так');
      return ResponseFromRequest(errorMessage: 'Что то пошло не так');
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }
}