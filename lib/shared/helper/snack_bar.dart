
import 'package:flutter/material.dart';

SnackBar snackBar(BuildContext context, String text, Color color){
  return SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
}