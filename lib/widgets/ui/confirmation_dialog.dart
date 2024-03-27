import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/widgets/ui/hspacer.dart';

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
                  closeDialog(context);
                },
                child: Text(t.ui.general.cancelButton),
              ),
              HSpacer(),
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
          ),
        ],
      ),
    );
  }
}