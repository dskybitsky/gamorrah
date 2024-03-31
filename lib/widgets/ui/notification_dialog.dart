import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';

class NotificationDialog extends StatelessWidget {
  NotificationDialog({
    required this.message,
  });

  final String message;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.ui.general.notificationTitle),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(t.ui.general.okButton),
        ),
      ],
    );
  }
}