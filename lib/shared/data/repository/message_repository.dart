

import 'dart:convert';
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/message.dart';
import 'package:barber_shop/shared/network/network.dart';
import 'package:http/http.dart' as http;

import 'barber_repository.dart';

class MessageRepository{

  Future<ResponseFromRequest> getMessageById(int id) async{
    try{
      final response = await http.get(Uri.parse('$baseURL/message/chatID/$id'));
      log('Status code: ${response.statusCode}');
      final data = json.decode(utf8.decode(response.bodyBytes)) as List;
      log('response from chatRepository: $data');



      List<Message> messages = data
          .map((messageJson) => Message.fromJson(messageJson))
          .toList();

      return ResponseFromRequest(response: messages);
    }on http.ClientException {
      log('Что то пошло не так');
      return ResponseFromRequest(errorMessage: 'Что то пошло не так');
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }

  Future<ResponseFromRequest> sendMessage(Message message) async{
    try{
      log('started sended message');
      var data = message.toJson();
      var uri = Uri.parse('$baseURL/message/send');
      var body = json.encode(data);

      var response = await http.post(
        uri,
        headers: headers,
        body: body,
      );
      log('end to send: ${response.statusCode}');

      return ResponseFromRequest(response: true);
    }on http.ClientException {
      log('Что то пошло не так');
      return ResponseFromRequest(errorMessage: 'Что то пошло не так');
    }catch (e){
      return ResponseFromRequest(errorMessage: e.toString());
    }

  }

}