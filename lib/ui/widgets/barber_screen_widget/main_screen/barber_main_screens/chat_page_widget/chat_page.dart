import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../domain/services/chat/chat_bubbles.dart';
import '../../../../../../domain/services/chat/chat_service.dart';


class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receivedUserId;

  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receivedUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if(_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receivedUserId,
          _messageController.text);
      //clear the text controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: _chatService.getMessage(
                      widget.receivedUserId,
                      _firebaseAuth.currentUser!.uid),
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Text('Error${snapshot.error}');
                    }

                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Text('Loading ...');
                    }

                    return ListView(
                      children: snapshot.data!.docs
                          .map((document) => _buildMessageItem(document))
                          .toList(),
                    );

                  }
              )
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Enter message',
                  ),
                  obscureText: false,
                ),
              ),
              IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.arrow_upward,
                    size: 40,
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map <String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    String time = DateFormat('hh:mm')
        .format(
        DateTime.fromMicrosecondsSinceEpoch(
            data['timestamp'].microsecondsSinceEpoch
        ));

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment:
          (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            ChatBubbles(
              message: data['message'],
              alignment: alignment,
              time: time,)
          ],
        ),
      ),
    );

  }

}
