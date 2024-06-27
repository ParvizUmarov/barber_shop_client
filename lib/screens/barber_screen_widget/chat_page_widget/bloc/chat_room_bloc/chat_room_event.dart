
import 'package:barber_shop/shared/data/entity/message.dart';

abstract class ChatRoomEvent{}

class GetMessageByChatId extends ChatRoomEvent{
  final int chatID;

  GetMessageByChatId({required this.chatID});
}

class SendMessage extends ChatRoomEvent{
  final Message message;

  SendMessage({required this.message});
}