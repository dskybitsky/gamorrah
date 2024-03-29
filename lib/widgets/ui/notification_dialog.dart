import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';

class NotificationDialog extends StatelessWidget {
  NotificationDialog({
    required this.message,
  });

  final String message;
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          Text(message),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(t.ui.general.okButton),
              ),
            ],
          ),
        ],
      ),
    );
  }
}