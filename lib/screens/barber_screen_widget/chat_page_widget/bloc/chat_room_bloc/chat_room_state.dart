

import 'package:barber_shop/shared/data/entity/message.dart';

abstract class ChatRoomState{}

class ChatRoomInitialState extends ChatRoomState{}

class ProgressChatRoomState extends ChatRoomState{}

class SuccessChatRoomState extends ChatRoomState{
  final List<Message> allMessage;

  SuccessChatRoomState({required this.allMessage});

}

class FailureChatRoomState extends ChatRoomState{}