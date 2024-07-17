
part of'customer_chat_bloc.dart';

abstract class CustomerChatState{}

class CustomerChatProgress extends CustomerChatState{}

class CustomerChatInitial extends CustomerChatState{}

class CustomerChatSuccess extends CustomerChatState{
  final List<Chat> chats;

  CustomerChatSuccess({required this.chats});
}

class CustomerChatFailure extends CustomerChatState{
  final String? errorMessage;

  CustomerChatFailure({required this.errorMessage});
}