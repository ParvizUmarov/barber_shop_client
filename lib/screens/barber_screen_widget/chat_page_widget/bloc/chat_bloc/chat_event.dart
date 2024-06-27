
abstract class ChatEvent{}

class ChatGetAllEvent extends ChatEvent{}

class ChatGetByBarberID extends ChatEvent{
  final int barberId;

  ChatGetByBarberID({required this.barberId});
}

