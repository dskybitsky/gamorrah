import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/state/game/games_bloc.dart';
import 'package:gamorrah/widgets/ui/vspacer.dart';

class GamePageModal extends StatefulWidget {
  const GamePageModal({ required this.game });

  final Game game;

  @override
  State<GamePageModal> createState() => _GameModalState();
}

class _GameModalState extends State<GamePageModal> {
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
    return ContentDialog(
      content: _buildDialogContent(context),
      actions: [
        Button(
          child: Text(t.ui.general.cancelButton),
          onPressed: () => Navigator.pop(context),
        ),
        FilledButton(
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

  Widget _buildDialogContent(BuildContext context) {
    return ListView(
      children: [
        InfoLabel(
          label: t.ui.gamePage.titleLabel,
          child: TextBox(
            controller: _titleController,
            placeholder: t.ui.gamePage.titlePlaceholder,
            expands: false,
          ),
        ),
        VSpacer(),
        InfoLabel(
          label: t.ui.gamePage.franchiseLabel,
          child: TextBox(
            controller: _franchiseController,
            placeholder: t.ui.gamePage.franchisePlaceholder,
            expands: false,
          ),
        ),
        VSpacer(),
        InfoLabel(
          label: t.ui.gamePage.editionLabel,
          child: TextBox(
            controller: _editionController,
            placeholder: t.ui.gamePage.editionPlaceholder,
            expands: false,
          ),
        ),
        VSpacer(),
        InfoLabel(
          label: t.ui.gamePage.yearLabel,
          child: NumberBox(
            placeholder: t.ui.gamePage.yearPlaceholder,
            value: _year,
            onChanged: (value) => { _year = value },
          ),
        ),
        VSpacer(),
        InfoLabel(
          label: t.ui.gamePage.thumbUrlLabel,
          child: TextBox(
            controller: _thumbUrlController,
            placeholder: t.ui.gamePage.thumbUrlPlaceholder,
            expands: false,
          ),
        ),
        VSpacer(),
        InfoLabel(
          label: t.ui.gamePage.platformsLabel,
          child: Expander(
            header: Wrap(
              children: _platforms
                .map((e) => Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: Text(
                    '${e.title}; ',
                    style: FluentTheme.of(context).typography.caption
                  ),
                )).toList(),
            ),
            content:
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: GamePlatform.values
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                            child: Checkbox(
                              checked: _platforms.contains(e),
                              onChanged: (selected) {
                                if (selected == true) { 
                                  setState(() => _platforms.add(e));
                                } else {
                                  setState(() => _platforms.remove(e));
                                }
                              },
                              content: Text(e.title),
                            ),
                          ),
                        )
                        .toList(),
                  ),
            ]),
          ),
        ),
      ],
    );
  }
}