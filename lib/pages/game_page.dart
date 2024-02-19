import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/pages/game_modal.dart';
import 'package:gamorrah/state/game/games_bloc.dart';
import 'package:gamorrah/widgets/game/game_thumb.dart';
import 'package:gamorrah/widgets/game/games_list.dart';
import 'package:gamorrah/widgets/game/games_navigator.dart';

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

  late GamePersonalBeaten? _personalBeaten;
  late double? _personalRating;
  late double? _personalTimeSpent;

  late double? _howLongToBeatStory;
  late double? _howLongToBeatStorySides;
  late double? _howLongToBeatCompletionist;

  late GameStatus _status;
  
  @override
  void initState() {
    super.initState();

    final game = _getGame();

    _kind = game?.kind;
    _personalBeaten = game?.personal?.beaten;
    _personalRating = game?.personal?.rating;
    _personalTimeSpent = game?.personal?.timeSpent;

    _howLongToBeatStory = game?.howLongToBeat?.story;
    _howLongToBeatStorySides = game?.howLongToBeat?.storySides;
    _howLongToBeatCompletionist = game?.howLongToBeat?.completionist;

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

        return NavigationView(
          appBar: NavigationAppBar(
              title: Text(game.title),
              actions: _buildActions(game),
          ),
          content: ScaffoldPage(
            content: ListView(
              padding: EdgeInsets.only(top: 8, left: 32, right: 32, bottom: 16),
              children: _buildFormWidgets(game, state),
            ),
          )
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
        size: GameThumbSize.large,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => GameModal(game: game),
            useRootNavigator: false,
          );
        }
      )
    );

    if (game.edition != null) {
      widgets.add(SizedBox(height: 8));

      widgets.add(Center(
        child: Text(
          game.edition!.toUpperCase(),
          style: FluentTheme.of(context).typography.caption,
        )
      ));
    }

    if (game.year != null) {
      widgets.add(SizedBox(height: 8));

      widgets.add(Center(
        child: Text(
          game.year!.toString(),
          style: FluentTheme.of(context).typography.caption,
        )
      ));
    }

    widgets.add(SizedBox(height: 32));

    widgets.add(
      Center(
        child: GamesList(
          games: includedGames, 
          thumbSize: GameThumbSize.small,
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

    widgets.add(SizedBox(height: 32));

    if (game.parentId == null) {
      widgets.add(
        _buildFormRow('Bundle:', ToggleSwitch(
          checked: _kind == GameKind.bundle,
          onChanged: (value) { 
            setState(() {
              _kind = value ? GameKind.bundle : null;
            });
          },
        ), expandChild: false)
      );
    } else {
      widgets.add(
        _buildFormRow('Kind:', ComboBox<GameKind?>(
          value: _kind,
          placeholder: Text('Game'),
          items: [
            ComboBoxItem(value: null, child: Text('Game')),
            ComboBoxItem(value: GameKind.dlc, child: Text('DLC/Expansion/Addon')),
            ComboBoxItem(value: GameKind.content, child: Text('Content Pack')),
          ],
          onChanged: (value) {
            setState(() {
              _kind = value;
            });
          },
          isExpanded: true,
        ))
      );
    }

    if (_kind != GameKind.bundle && _kind != GameKind.content) {
      widgets.add(SizedBox(height: 24));

      widgets.add(
        _buildFormRow('PERSONAL', Container())
      );

      widgets.add(SizedBox(height: 16));

      widgets.add(
        _buildFormRow('Beaten:', ComboBox<GamePersonalBeaten?>(
          value: _personalBeaten,
          placeholder: Text('No'),
          items: [
            ComboBoxItem(value: null, child: Text('No')),
            ComboBoxItem(
              value: GamePersonalBeaten.story, 
              child: Row(
                children: [
                  const Icon(FluentIcons.check_mark),
                  const SizedBox(width: 8),
                  const Text('Story'),
                ]
              ),
            ),
            ComboBoxItem(
              value: GamePersonalBeaten.storySides, 
              child: Row(
                children: [
                  const Icon(FluentIcons.check_list),
                  const SizedBox(width: 8),
                  const Text('Story + Sides'),
                ]
              ),
            ),
            ComboBoxItem(
              value: GamePersonalBeaten.completionist,
              child: Row(
                children: [
                  const Icon(FluentIcons.medal),
                  const SizedBox(width: 8),
                  const Text('Completionist'),
                ]
              ),
            ),
          ],
          onChanged: ( value) {
            setState(() {
              _personalBeaten = value;
            });
          },
          isExpanded: true,
        ))
      );

      widgets.add(SizedBox(height: 16));

      widgets.add(
        _buildFormRow('Rating:', RatingBar(
          rating: _personalRating ?? 0,
          unratedIconColor: FluentTheme.of(context).inactiveBackgroundColor,
          onChanged: (value) {
            setState(() {
              _personalRating = ((value * 2).round() / 2 );
            });
          },
        ), expandChild: false)
      );

      widgets.add(SizedBox(height: 16));

      widgets.add(
        _buildFormRow('Time Spent:', NumberBox(
          placeholder: 'Hours',
          value: _personalTimeSpent,
          onChanged: (value) => { _personalTimeSpent = value },
        ))
      );

      widgets.add(SizedBox(height: 24));

      widgets.add(
        _buildFormRow('HOWLONGTOBEAT', Container())
      );

      widgets.add(SizedBox(height: 16));

      widgets.add(
        _buildFormRow('Story:', NumberBox(
          placeholder: 'Hours',
          value: _howLongToBeatStory,
          onChanged: (value) => { _howLongToBeatStory = value },
        ))
      );

      widgets.add(SizedBox(height: 16));

      widgets.add(
        _buildFormRow('Story + Sides:', NumberBox(
          placeholder: 'Hours',
          value: _howLongToBeatStorySides,
          onChanged: (value) => { _howLongToBeatStorySides = value },
        ))
      );

      widgets.add(SizedBox(height: 16));

      widgets.add(
        _buildFormRow('Completionist:', NumberBox(
          placeholder: 'Hours',
          value: _howLongToBeatCompletionist,
          onChanged: (value) => { _howLongToBeatCompletionist = value },
        ))
      );
    }    

    widgets.add(SizedBox(height: 32));

    widgets.add(
      _buildFormRow('Status:', ComboBox<GameStatus>(
        value: _status,
        items: [
          ComboBoxItem(
            value: GameStatus.backlog, 
            child: Row(
              children: [
                const Icon(FluentIcons.history),
                const SizedBox(width: 8),
                const Text('Backlog'),
              ]
            ),
          ),
          ComboBoxItem(
            value: GameStatus.playing, 
            child: Row(
              children: [
                const Icon(FluentIcons.play),
                const SizedBox(width: 8),
                const Text('Playing'),
              ]
            )
          ),
          ComboBoxItem(
            value: GameStatus.finished,
            child: Row(
              children: [
                const Icon(FluentIcons.completed),
                const SizedBox(width: 8),
                const Text('Finished'),
              ]
            )
          ),
          ComboBoxItem(
            value: GameStatus.wishlist,
            child: Row(
              children: [
                const Icon(FluentIcons.waitlist_confirm),
                const SizedBox(width: 8),
                const Text('Wishlist'),
              ]
            )
          ),
        ],
        onChanged: ( value) {
          setState(() {
            _status = value ?? GameStatus.backlog;
          });
        },
        isExpanded: true,
      ))
    );

    widgets.add(SizedBox(height: 24));

    widgets.add(
      _buildFormRow(null, FilledButton(
        onPressed: () {
          context.read<GamesBloc>().add(
            SaveGame(game: game.copyWith(
              kind: Optional(_kind),
              personal: Optional(game.copyPersonalWith(
                beaten: Optional(_personalBeaten),
                rating: Optional(_personalRating),
                timeSpent: Optional(_personalTimeSpent),
              )),
              howLongToBeat: Optional(game.copyHowLongToBeatWith(
                story: Optional(_howLongToBeatStory),
                storySides: Optional(_howLongToBeatStorySides),
                completionist: Optional(_howLongToBeatCompletionist),
              )),
              status: Optional(_status),
            ))
          );
          Navigator.pop(context);
        },
        child: Text('Save'),
      ))
    );

    return widgets;
  }

  Widget _buildFormRow(String? label, Widget child, { bool expandChild = true }) {
    final innerChildren = <Widget>[];

    if (label != null) {
      innerChildren.add(Expanded(flex: 2, child: Text(label)));
    }

    innerChildren.add(expandChild ? Expanded(flex: 3, child: child) : child);

    return Row(
      children: [
        Expanded(flex: 1, child: Container(),),
        Expanded(
          flex: 3,
          child: Row(
            children: innerChildren,
          )
        ),
        Expanded(flex: 1, child: Container()),
      ] 
    );
  }

  Widget _buildActions(Game game) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: 
            CommandBar(
              mainAxisAlignment: MainAxisAlignment.end,
              primaryItems: [
                CommandBarButton(
                  icon: const Icon(FluentIcons.add),
                  label: const Text('Add Included Item'),
                  onPressed: () {
                    final game = Game.create(
                      title: 'New included game',
                      status: GameStatus.backlog,
                      parentId: widget.id
                    );

                    context.read<GamesBloc>().add(SaveGame(game: game));

                    GamesNavigator.goGame(context, id: game.id);
                  },
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.delete),
                  label: const Text('Delete'),
                  onPressed: () {
                    context.read<GamesBloc>().add(DeleteGame(id: widget.id));

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
        ),
      ]
    );
  }

  Game? _getGame() {
    final games = context.read<GamesBloc>().state.games;

    return games.firstWhereOrNull((element) => element.id == widget.id);
  }
}