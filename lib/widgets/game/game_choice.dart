import 'package:choice/choice.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:my_game_db/i18n/strings.g.dart';
import 'package:my_game_db/models/game/game.dart';
import 'package:my_game_db/widgets/game/game_thumb.dart';

class GameChoice extends StatefulWidget {
  const GameChoice({
    super.key,
    this.value,
    this.id,
    this.games = const [],
    this.onChanged,
  });

  final String? value;
  final String? id;
  final List<Game> games;
  final void Function(String?)? onChanged;

  @override
  State<GameChoice> createState() => _GameChoiceState();
}

class _GameChoiceState extends State<GameChoice> {
  late ChoiceData<Game>? _value;

  @override
  void initState() {
    super.initState();

    final game = widget.value != null
      ? widget.games.firstWhere((element) => element.id == widget.value)
      : null;

    _value = game != null ? _createChoice(game) : null;
  }

  @override
  Widget build(BuildContext context) {
    final choices = _getChoices();

    return PromptedChoice<ChoiceData<Game>>.single(
      title: t.ui.gamesControl.title,
      clearable: true,
      searchable: true,
      value: _value,
      onChanged: _onChanged,
      itemCount: choices.length,
      itemSkip: (state, i) =>
        !ChoiceSearch.match(choices[i].title, state.search?.value),
      itemBuilder: (state, i) {
        return RadioListTile<ChoiceData<Game>>(
          value: choices[i],
          groupValue: state.single,
          onChanged: (value) {
            state.select(choices[i]);
          },
          title: ChoiceText(
            choices[i].title,
            highlight: state.search?.value,
          ),
          subtitle: choices[i].subtitle != null
            ? Text(
                choices[i].subtitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
          secondary: choices[i].image != null
            ? GameThumb(game: choices[i].value, type: GameThumbType.micro)
            : null,
        );
      },
      modalHeaderBuilder: ChoiceModal.createHeader(
        automaticallyImplyLeading: false,
        actionsBuilder: [
          ChoiceModal.createSpacer(width: 5),
        ],
      ),
      promptDelegate: ChoicePrompt.delegatePopupDialog(
        maxHeightFactor: .7,
        constraints: const BoxConstraints(maxWidth: 300),
      ),
      anchorBuilder: ChoiceAnchor.create(inline: true),
    );
  }

  List<ChoiceData<Game>> _getChoices() {
    return widget.games
      .where((element) => element.id != widget.id)
      .sorted()
      .map((game) => _createChoice(game)).toList();
  }

  ChoiceData<Game> _createChoice(Game game) {
    return ChoiceData(
      value: game, 
      title: game.title,
      subtitle: game.edition,
      image: game.thumbUrl
    );
  }

  void _onChanged(ChoiceData<Game>? value) {
    setState(() {
      _value = value;
      _widgetOnChanged();
    });
  }

  void _widgetOnChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(_value?.value.id);
    }
  }
}