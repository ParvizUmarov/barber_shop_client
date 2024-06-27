
import 'package:barber_shop/shared/data/entity/chat.dart';

abstract class ChatState{}

class ChatInitialState extends ChatState{}

class ProgressChatState extends ChatState{}

class SuccessChatState extends ChatState{
  final List<Chat> allChats;

  SuccessChatState({required this.allChats});
}

class FailureChatState extends ChatState{}
