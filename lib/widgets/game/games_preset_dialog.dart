import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';

class GamesPresetDialog extends StatefulWidget {
  const GamesPresetDialog({
    this.onChanged,
  });

  final void Function(String)? onChanged;

  @override
  State<GamesPresetDialog> createState() => _GamesPresetDialogState();
}

class _GamesPresetDialogState extends State<GamesPresetDialog> {
  late TextEditingController _nameController;
  
  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: 'New Preset');
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