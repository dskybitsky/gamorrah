import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_game_db/i18n/strings.g.dart';
import 'package:my_game_db/models/games_view/games_view.dart';
import 'package:my_game_db/models/optional.dart';
import 'package:my_game_db/widgets/ui/spacer.dart';

class GamesPageSaveViewDialog extends StatefulWidget {
  const GamesPageSaveViewDialog({
    required this.value,
    this.onChanged,
  });

  final GamesView value;
  final void Function(GamesView)? onChanged;

  @override
  State<GamesPageSaveViewDialog> createState() => _GamesGamesPageSaveViewDialogState();
}

class _GamesGamesPageSaveViewDialogState extends State<GamesPageSaveViewDialog> {
  late TextEditingController _nameController;
  late int _index;
  
  @override
  void initState() {
    super.initState();

    _index = widget.value.index;
    _nameController = TextEditingController(text: widget.value.name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.ui.gamesPage.saveViewDialogTitle),
      content: SizedBox(
        width: 380,
        child: Row(
          children: [
            Expanded(flex: 1, child: TextFormField(
              initialValue: _index.toString(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                setState(() {
                  _index = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: t.ui.gamesPage.saveViewDialogIndexLabel,
              ),
            )),
            HSpacer(),
            Expanded(flex: 3, child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: t.ui.gamesPage.saveViewDialogNameLabel,
              ),
            )),
          ],
        ),
      ),
      actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.ui.general.cancelButton),
          ),
          TextButton(
            onPressed: () {
              final onChanged = widget.onChanged;

              if (onChanged != null) {
                onChanged(widget.value.copyWith(
                  name: Optional(_nameController.text),
                  index: Optional(_index),
                ));
              }
              
              Navigator.pop(context);
            },
            child: Text(t.ui.general.saveButton)
          )
        ],
    );
  }
}