import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/widgets/ui/hspacer.dart';
import 'package:gamorrah/widgets/ui/vspacer.dart';

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
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VSpacer(),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: t.ui.gamePage.titlePlaceholder,
                ),
              ),
            ),
            VSpacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(t.ui.general.cancelButton),
                ),
                HSpacer(),
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
      ),
    );
  }
}