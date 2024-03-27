import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/pages/game_page_dialog.dart';
import 'package:gamorrah/state/game/games_bloc.dart';
import 'package:gamorrah/widgets/game/game_how_long_to_beat_input.dart';
import 'package:gamorrah/widgets/game/game_personal_input.dart';
import 'package:gamorrah/widgets/game/game_status_input.dart';
import 'package:gamorrah/widgets/game/game_thumb.dart';
import 'package:gamorrah/widgets/game/games_list.dart';
import 'package:gamorrah/widgets/game/games_navigator.dart';
import 'package:gamorrah/widgets/ui/confirmation_dialog.dart';
import 'package:gamorrah/widgets/ui/hspacer.dart';
import 'package:gamorrah/widgets/ui/labeled_input.dart';
import 'package:gamorrah/widgets/ui/space_size.dart';
import 'package:gamorrah/widgets/ui/vspacer.dart';

class GamePage extends StatefulWidget {
  const GamePage({ 
    required this.id,
  });

  final String id;
  
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final String id;
  
  late GameKind? _kind;

  late GamePersonal? _personal;
  late GameHowLongToBeat? _howLongToBeat;

  late GameStatus _status;
  
  @override
  void initState() {
    super.initState();

    final game = _getGame();

    _kind = game?.kind;
    
    _personal = game?.personal;
    _howLongToBeat = game?.howLongToBeat;

    _status = game?.status ?? GameStatus.backlog;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, GamesState>(
      builder: (context, state) {
        Game? game = _getGame();

        if (game == null) {
          return Container();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(game.title),
            actions: _buildActions(game),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              final game = Game.create(
                title: t.ui.gamePage.defaultIncludedGameTitle,
                status: GameStatus.backlog,
                parentId: widget.id
              );

              context.read<GamesBloc>().add(SaveGame(game: game));

              GamesNavigator.goGame(context, id: game.id);
            },
          ),
          body: ListView(
            padding: EdgeInsets.only(top: 8, left: 32, right: 32, bottom: 16),
            children: _buildFormWidgets(game, state),
          ),
        );
      }
    );
  }

  List<Widget> _buildFormWidgets(Game game, GamesState state) {
    final includedGames = state.games
      .where((element) => element.parentId == game.id)
      .toList();

    includedGames
      .sort((gameA, gameB) => (gameA.index ?? 0).compareTo(gameB.index ?? 0));

    var widgets = <Widget>[];

    widgets.add(
      GameThumb(
        game: game,
        type: GameThumbType.large,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => GamePageDialog(game: game),
            useRootNavigator: false,
          );
        }
      )
    );

    if (game.edition != null) {
      widgets.add(VSpacer(size: SpaceSize.s));

      widgets.add(Center(
        child: Text(
          game.edition!.toUpperCase(),
          // style: FluentTheme.of(context).typography.caption,
        )
      ));
    }

    if (game.year != null) {
      widgets.add(VSpacer(size: SpaceSize.s));

      widgets.add(Center(
        child: Text(
          game.year!.toString(),
          // style: FluentTheme.of(context).typography.caption,
        )
      ));
    }

    widgets.add(VSpacer());

    widgets.add(
      Center(
        child: GamesList(
          games: includedGames, 
          thumbType: GameThumbType.small,
          onReorder: (oldIndex, newIndex) {
            var games = includedGames.toList();

            final movingGame = games.removeAt(oldIndex);

            games.insert(newIndex, movingGame);

            context.read<GamesBloc>().add(
              SaveGames(
                games: games.indexed.map((e) => e.$2.copyWith(index: Optional(e.$1)))
              )
            );
          },
        )
      )
    );

    widgets.add(VSpacer());

    if (game.parentId == null) {
      widgets.add(
        LabeledInput(
          label: Text(t.ui.gamePage.kindBundleLabel), 
          expanded: false,
          child: Switch(
            value: _kind == GameKind.bundle,
            onChanged: (value) { 
              setState(() {
                _kind = value ? GameKind.bundle : null;
              });
            },
          ),
        )
      );
    } else {
      widgets.add(
        LabeledInput(
          label: Text(t.ui.gamePage.kindLabel),
          child: DropdownMenu<GameKind?>(
            initialSelection: _kind,
            dropdownMenuEntries: [
              DropdownMenuEntry(value: null, label: t.types.gameKind.none),
              DropdownMenuEntry(value: GameKind.dlc, label: t.types.gameKind.dlc),
              DropdownMenuEntry(value: GameKind.content, label: t.types.gameKind.content),
            ],
            onSelected: (value) {
              setState(() {
                _kind = value;
              });
            },
          )
        )
      );
    }

    if (_kind == null || _kind == GameKind.dlc) {
      widgets.add(VSpacer(size: SpaceSize.l));

      widgets.add(
        GamePersonalInput(
          value: _personal ?? GamePersonal(),
          onChanged: (personal) {
            setState(() {
              _personal = personal;
            });
          },
        )
      );

      widgets.add(VSpacer());

      widgets.add(
        GameHowLongToBeatInput(
          value: _howLongToBeat ?? GameHowLongToBeat(),
          onChanged: (howLongToBeat) {
            setState(() {
              _howLongToBeat = howLongToBeat;
            });
          },
        )
      );
    } 

    if (game.parentId == null) {
      widgets.add(VSpacer());

      widgets.add(
        LabeledInput(
          label: Text(t.ui.gamePage.statusLabel),
          child: GameStatusInput(
            value: _status,
            onChanged: (value) {
              setState(() {
                _status = value ?? GameStatus.backlog;
              });
            },
          )
        )
      );
    }

    widgets.add(VSpacer(size: SpaceSize.l));

    widgets.add(
      FilledButton(
        onPressed: () {
          context.read<GamesBloc>().add(
            SaveGame(game: game.copyWith(
              kind: Optional(_kind),
              personal: Optional(_personal),
              howLongToBeat: Optional(_howLongToBeat),
              status: Optional(_status),
            ))
          );
          Navigator.pop(context);
        },
        child: Text(t.ui.general.saveButton),
      )
    );

    return widgets;
  }

  List<Widget> _buildActions(Game game) {
    final List<Widget> widgets = [];

    widgets.add(
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          _handleDelete(context);
        },
      ),
    );

    widgets.add(HSpacer(size: SpaceSize.l));

    return widgets;
  }

  Game? _getGame() {
    final games = context.read<GamesBloc>().state.games;

    return games.firstWhereOrNull((element) => element.id == widget.id);
  }

  void _handleDelete(BuildContext context) async {
    final block = context.read<GamesBloc>();

    goBack() {
      Navigator.pop(context);
    }

    showDialog(
      context: context, 
      builder: (context) {
        return ConfirmationDialog(
          message: t.ui.gamePage.deleteGameConfirmationMessage,
          callback: () async {
            block.add(DeleteGame(id: widget.id));
            goBack();
          }
        );
      }
    );
  }
}