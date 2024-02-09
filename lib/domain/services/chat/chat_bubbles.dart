import 'package:flutter/material.dart';

import '../../../ui/theme/colors/Colors.dart';

class ChatBubbles extends StatelessWidget {
  final Alignment alignment;
  final String message;
  final String time;
  const ChatBubbles({super.key,
    required this.message,
    required this.alignment,
    required this.time});

  @override
  Widget build(BuildContext context) {
    bool isSender = alignment == Alignment.centerRight;
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSender
              ? AppColors.mainColor
              : Colors.grey[200]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                    fontSize: 16,
                    color: isSender
                        ? Colors.white
                        : Colors.black
                ),
              ),
            ],
          ),
      Row(
        mainAxisAlignment: isSender
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Text(time,
              style: TextStyle(color: Colors.grey),),
        ],
      ),
        ],
      ),
    );
  }
}