import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

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

    return ContentDialog(
      content: Text(message),
      actions: [
        FilledButton(
          onPressed: () async {
            await callback();
            
            if (context.mounted) {
              closeDialog(context);
            }
          },
          child: Text('OK'),
        ),
        Button(
          autofocus: true,
          onPressed: () {
            closeDialog(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}