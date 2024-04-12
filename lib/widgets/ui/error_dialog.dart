import 'package:flutter/material.dart';
import 'package:my_game_db/i18n/strings.g.dart';
import 'package:my_game_db/widgets/ui/spacer.dart';

class ErrorDialog extends StatelessWidget {
  ErrorDialog({
    required this.message,
    this.details,
  });

  final String message;
  final String? details;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.ui.general.errorTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          if (details != null)
            VSpacer(),
            Text(details!)
        ],
      ),
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