import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/state/game/games_bloc.dart';
import 'package:gamorrah/widgets/game/game_platforms_input.dart';
import 'package:gamorrah/widgets/ui/spacer.dart';

class GamePageDialog extends StatefulWidget {
  const GamePageDialog({ required this.game });

  final Game game;

  @override
  State<GamePageDialog> createState() => _GamePageDialogState();
}

class _GamePageDialogState extends State<GamePageDialog> {
  late TextEditingController _titleController;
  late TextEditingController _franchiseController;
  late TextEditingController _editionController;
  late int? _year;
  late TextEditingController _thumbUrlController;
  late Set<GamePlatform> _platforms;
  
  @override
  void initState() {
    super.initState();

     _titleController = TextEditingController(text: widget.game.title);
     _franchiseController = TextEditingController(text: widget.game.franchise);
     _editionController = TextEditingController(text: widget.game.edition);
     _year = widget.game.year;
     _thumbUrlController = TextEditingController(text: widget.game.thumbUrl);
     _platforms = Set.from(widget.game.platforms);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.ui.gamePage.dialogTitle),
      content: _buildContent(context),
      actions: [
        TextButton(
          child: Text(t.ui.general.cancelButton),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          onPressed: () {
            context.read<GamesBloc>().add(
              SaveGame(game: widget.game.copyWith(
                title: Optional(_titleController.text),
                franchise: Optional(_franchiseController.text),
                edition: Optional(_editionController.text),
                year: Optional(_year),
                thumbUrl: Optional(_thumbUrlController.text),
                platforms: Optional(_platforms),
              ))
            );
            Navigator.pop(context);
          },
          child: Text(t.ui.general.saveButton),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: t.ui.gamePage.titleLabel,
            ),
          ),
          VSpacer(),
          TextField(
            controller: _franchiseController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: t.ui.gamePage.franchiseLabel,
            ),
          ),
          VSpacer(),
          TextField(
            controller: _editionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: t.ui.gamePage.editionLabel,
            ),
          ),
          VSpacer(),
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              _year = int.parse(value);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: t.ui.gamePage.yearLabel,
            ),
          ),
          VSpacer(),
          TextField(
            controller: _thumbUrlController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: t.ui.gamePage.thumbUrlLabel,
            ),
          ),
          VSpacer(),
          GamePlatformsInput(
            value: _platforms,
            onChanged: (value) {
              setState((){ 
                _platforms = value;
              });
            },
          ),
        ],
      ),
    );
  }
}