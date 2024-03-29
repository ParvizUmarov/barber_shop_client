import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../shared/theme/colors/Colors.dart';
import 'chat_bubbles.dart';
import '../../../domain/services/chat/chat_service.dart';

class ChatRoom extends StatefulWidget {
  final String receiverUserEmail;
  final String receivedUserId;

  const ChatRoom(
      {super.key,
      required this.receiverUserEmail,
      required this.receivedUserId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: _ChatBody(
        receivedUserId: widget.receivedUserId,
      ),
    );
  }
}

class _ChatBody extends StatelessWidget {
  final String receivedUserId;

  const _ChatBody({super.key, required this.receivedUserId});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final TextEditingController messageController = TextEditingController();
    final ChatService chatService = ChatService();

    return Column(
      children: [
        _MessageArea(
            receivedUserId: receivedUserId,
            chatService: chatService,
            firebaseAuth: firebaseAuth),
        _MessageBarWidget(
          messageController: messageController,
          receivedUserId: receivedUserId,
          chatService: chatService,
        ),
      ],
    );
  }
}

class _MessageArea extends StatelessWidget {
  final String receivedUserId;
  final ChatService chatService;
  final FirebaseAuth firebaseAuth;

  const _MessageArea(
      {super.key,
      required this.receivedUserId,
      required this.chatService,
      required this.firebaseAuth});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: chatService.getMessage(
            receivedUserId, firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          }

          if(snapshot.data!.docs.isEmpty){
            print(snapshot.hasData);
            return Center(
              child: Text('Нет сообщение', style: TextStyle(color: Colors.grey),));
          }

          return ListView(
            children: snapshot.data!.docs
                .map((document) => _BuildMessageItem(document: document))
                .toList(),
          );
        },
      ),
    );
  }
}

class _MessageBarWidget extends StatelessWidget {
  const _MessageBarWidget({
    super.key,
    required this.messageController,
    required this.receivedUserId,
    required this.chatService,
  });

  final String receivedUserId;
  final TextEditingController messageController;
  final ChatService chatService;

  @override
  Widget build(BuildContext context) {
    void sendMessage() async {
      if (messageController.text.isNotEmpty) {
        await chatService.sendMessage(receivedUserId, messageController.text);
        //clear the text controller after sending the message
        messageController.clear();
      }
    }

    return Container(
      color: Theme.of(context).colorScheme.secondary,
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              color: AppColors.mainColor,
              Icons.add_box_outlined,
              size: 30,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 55,
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primary,
                  hintText: 'Сообщение',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.transparent)),
                ),
                obscureText: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(
                color: AppColors.mainColor,
                Icons.send,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildMessageItem extends StatelessWidget {
  final DocumentSnapshot document;

  const _BuildMessageItem({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    int dateTime = data['timestamp'].microsecondsSinceEpoch;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == firebaseAuth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            ChatBubbles(
                message: data['message'], alignment: alignment, dateTime: dateTime),
            // Text(time,
            //   style: TextStyle(color: Colors.grey),),
            //Text('$timestamp')
          ],
        ),
      ),
    );
  }
}
