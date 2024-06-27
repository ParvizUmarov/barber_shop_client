
import 'dart:convert';
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/chat.dart';
import 'package:barber_shop/shared/network/network.dart';
import 'package:http/http.dart' as http;

import 'barber_repository.dart';

class ChatRepository{

  Future<ResponseFromRequest> getAllChats() async{
    try{
      final response = await http.get(Uri.parse('$baseURL/chat'));
      log('Status code: ${response.statusCode}');
      final data = jsonDecode(response.body);
      log('response from chatRepository: $data');

      List<Chat> chats = (jsonDecode(response.body) as List)
          .map((chatJson) => Chat.fromJson(chatJson))
          .toList();

      return ResponseFromRequest(response: chats);
    }on http.ClientException {
      log('Что то пошло не так');
      return ResponseFromRequest(errorMessage: 'Что то пошло не так');
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }
  }

  Future<ResponseFromRequest> getChatByBarberId(int id) async{
    try{
      final response = await http.get(Uri.parse('$baseURL/chat/barberID/$id'));
      log('Status code: ${response.statusCode}');
      final data = jsonDecode(response.body);
      log('response from chatRepository: $data');

      List<Chat> chats = (jsonDecode(response.body) as List)
          .map((chatJson) => Chat.fromJson(chatJson))
          .toList();

      return ResponseFromRequest(response: chats);
    }on http.ClientException {
      log('Что то пошло не так');
      return ResponseFromRequest(errorMessage: 'Что то пошло не так');
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }
  }

}