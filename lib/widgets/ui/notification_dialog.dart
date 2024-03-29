import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/i18n/strings.g.dart';

class NotificationDialog extends StatelessWidget {

  NotificationDialog({
    required this.message,
  });

  final String message;
  
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      content: Text(message),
      actions: [
        Button(
          autofocus: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(t.ui.general.okButton),
        ),
      ],
    );
  }
}