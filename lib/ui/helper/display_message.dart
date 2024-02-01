import 'package:flutter/material.dart';

import '../../resources/resources.dart';

void displayErrorMessage(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text('Ошибка'),
      content: Text(message.toString()),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Повторить еще раз'),
        ),
      ],
    ),
  );
}

void displayAlertDialog(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text(message),
            actions: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Отмена'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Да'),
              )
            ],
          ));
}

void snackBarMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: EdgeInsets.all(16),
        height: 100,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Image.asset(Images.errorIcon),
            SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ошибка!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
