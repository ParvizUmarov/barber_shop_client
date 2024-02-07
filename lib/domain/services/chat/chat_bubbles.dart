import 'package:flutter/material.dart';

import '../../../ui/theme/colors/Colors.dart';

class ChatBubbles extends StatelessWidget {
  final String message;
  const ChatBubbles({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.mainColor
      ),
      child: Text(
        message,
        style: const TextStyle(
            fontSize: 16,
            color: Colors.white
        ),
      ),
    );
  }
}