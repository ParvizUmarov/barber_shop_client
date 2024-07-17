
import 'dart:developer';

import 'package:barber_shop/shared/data/entity/message.dart';
import 'package:barber_shop/shared/data/repository/message_repository.dart';
import 'package:bloc/bloc.dart';

class SendMessageCubit extends Cubit<Action>{
  SendMessageCubit() : super(Action.initial);

  MessageRepository repository = MessageRepository();

  sendMessage(Message message) async {
    log('send message from bloc: $message');
     repository.sendMessage(message);
     //emit(Action.send);
  }

}

enum Action{
  initial,
  send
}