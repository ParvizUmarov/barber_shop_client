
import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final int? id;
  final int chatId;
  final String message;
  final String time;

  Message({
    this.id,
    required this.chatId,
    required this.message,
    required this.time});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      chatId: json['chatId'],
      message: json['message'],
      time: json['time'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'message': message,
      'time': time,
    };
  }

  @override
  String toString() {
    return 'Message{id: $id, chatId: $chatId, message: $message, time: $time}';
  }
}