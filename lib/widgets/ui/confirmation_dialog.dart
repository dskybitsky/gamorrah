import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:my_game_db/i18n/strings.g.dart';

class ConfirmationDialog extends StatelessWidget {
  ConfirmationDialog({
    required this.message,
    required this.callback,
  });

  final String message;
  final AsyncCallback callback;
  
  @override
  Widget build(BuildContext context) {
    closeDialog(BuildContext context) => Navigator.pop(context);

    return AlertDialog(
      title: Text(t.ui.general.confimationTitle),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            closeDialog(context);
          },
          child: Text(t.ui.general.cancelButton),
        ),
        TextButton(
          onPressed: () async {
            await callback();
          
            if (context.mounted) {
              closeDialog(context);
            }
          },
          child: Text(t.ui.general.okButton),
        ),
      ],
    );
  }
}