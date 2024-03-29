import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:gamorrah/i18n/strings.g.dart';

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
        Button(
          onPressed: () {
            closeDialog(context);
          },
          child: Text(t.ui.general.cancelButton),
        ),
        FilledButton(
          autofocus: true,
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