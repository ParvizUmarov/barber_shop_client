
import 'dart:convert';
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/stores.dart';
import 'package:barber_shop/shared/network/network.dart';
import 'package:http/http.dart' as http;

import 'barber_repository.dart';

class StoresRepository {

  Future<ResponseFromRequest> getAllStores(String mail, String token) async {
    try{
      var response = await http.get(
        Uri.parse('$baseURL/stores'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token
        },
      );

      final data = json.decode(utf8.decode(response.bodyBytes)) as List;
      log('response from all stores: $data');

      List<Stores> stores = data
          .map((barberJson) => Stores.fromJson(barberJson))
          .toList();

      return ResponseFromRequest(response: stores);
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }


}