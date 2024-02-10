import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

import '../../theme/colors/Colors.dart';

class ChatBubbles extends StatelessWidget {
  final Alignment alignment;
  final String message;
  final String time;

  const ChatBubbles(
      {super.key,
      required this.message,
      required this.alignment,
      required this.time});

  @override
  Widget build(BuildContext context) {
    bool isSender = alignment == Alignment.centerRight;
    return Column(
      children: [
        BubbleNormal(
          text: message,
          seen: true,
          tail: true,
          isSender: isSender,
          color: isSender ? AppColors.mainColor : Color(-2894849),
          textStyle: TextStyle(
              color: isSender ? Colors.white : Colors.black,
              fontSize: 16),
        ),
        Row(
          mainAxisAlignment: isSender
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(time),
            ),
          ],
        )
      ],
    );
  }
}
