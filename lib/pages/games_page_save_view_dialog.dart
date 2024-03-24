import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';

class GamesPageSaveViewDialog extends StatefulWidget {
  const GamesPageSaveViewDialog({
    this.value = '',
    this.onChanged,
  });

  final String value;
  final void Function(String)? onChanged;

  @override
  State<GamesPageSaveViewDialog> createState() => _GamesGamesPageSaveViewDialogState();
}

class _GamesGamesPageSaveViewDialogState extends State<GamesPageSaveViewDialog> {
  late TextEditingController _nameController;
  
  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: t.ui.gamePage.titlePlaceholder,
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(t.ui.general.cancelButton),
              ),
              TextButton(
                onPressed: () {
                  final onChanged = widget.onChanged;

                  if (onChanged != null) {
                    onChanged(_nameController.text);
                  }
                  
                  Navigator.pop(context);
                },
                child: Text(t.ui.general.saveButton)
              )
            ],
          ),
        ]
      ),
    );
  }
}