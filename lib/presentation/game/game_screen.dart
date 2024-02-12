import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/models/wrapped.dart';
import 'package:gamorrah/presentation/game/modal.dart';
import 'package:gamorrah/presentation/game/list.dart';
import 'package:gamorrah/presentation/game/thumb.dart';
import 'package:gamorrah/presentation/game/navigator.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({ 
    this.id,
    this.status,
    this.parentId,
  });

  final String? id;
  final GameStatus? status;
  final String? parentId;
  
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final String id;
  late final GameService service;

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

    service = Get.find();

    Game game = _initGame();

    id = game.id;

    _kind = game.kind;
    _personalBeaten = game.personal?.beaten;
    _personalRating = game.personal?.rating;
    _personalTimeSpent = game.personal?.timeSpent;

    _howLongToBeatStory = game.howLongToBeat?.story;
    _howLongToBeatStorySides = game.howLongToBeat?.storySides;
    _howLongToBeatCompletionist = game.howLongToBeat?.completionist;

    _status = game.status;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: service, 
      builder: (context, widget) {
        Game? game = service.get(id);

        if (game == null) {
          return Container();
        }

        return NavigationView(
          appBar: NavigationAppBar(
              title: Text(game.title),
              actions: _buildActions(game),
          ),
          content: ScaffoldPage(
            content: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 3, 
                    child: ListView(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      children: _buildFormWidgets(game),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
          )
        ); 
      }
    );
  }

  List<Widget> _buildFormWidgets(Game game) {
    final includedGames = service.getIncludedList(game.id).toList();

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
        child: GameList(
          games: includedGames, 
          thumbSize: GameThumbSize.small,
          onReorder: (oldIndex, newIndex) {
            service.reorderIncluded(game.id, oldIndex, newIndex);
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

    if (_kind != GameKind.bundle) {
      widgets.add(SizedBox(height: 32));

      widgets.add(
        Container(
          alignment: Alignment.centerLeft, 
          child: Text('PERSONAL'),
        )
      );

      widgets.add(SizedBox(height: 16));

      widgets.add(
        _buildFormRow('Beaten:', ComboBox<GamePersonalBeaten?>(
          value: _personalBeaten,
          items: [
            ComboBoxItem(value: null, child: Text('')),
            ComboBoxItem(value: GamePersonalBeaten.story, child: Text('Story')),
            ComboBoxItem(value: GamePersonalBeaten.storySides, child: Text('Story + Sides')),
            ComboBoxItem(value: GamePersonalBeaten.completionist, child: Text('Completionist')),
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
        _buildFormRow('Rating:', NumberBox(
          placeholder: 'Rating',
          value: _personalRating,
          onChanged: (value) => { _personalRating = value },
        ))
      );

      widgets.add(SizedBox(height: 16));

      widgets.add(
        _buildFormRow('Time Spent:', NumberBox(
          placeholder: 'Hours',
          value: _personalTimeSpent,
          onChanged: (value) => { _personalTimeSpent = value },
        ))
      );

      widgets.add(SizedBox(height: 32));

      widgets.add(
        Container(
          alignment: Alignment.centerLeft, 
          child: Text('HOWLONGTOBEAT'),
        )
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
          ComboBoxItem(value: GameStatus.backlog, child: Text('Backlog')),
          ComboBoxItem(value: GameStatus.playing, child: Text("Playing")),
          ComboBoxItem(value: GameStatus.finished, child: Text("Finished")),
          ComboBoxItem(value: GameStatus.wishlist, child: Text("Wishlist")),
        ],
        onChanged: ( value) {
          setState(() {
            _status = value ?? GameStatus.backlog;
          });
        },
        isExpanded: true,
      ))
    );

    widgets.add(SizedBox(height: 32));

    widgets.add(
      FilledButton(
        onPressed: () {
          service.save(game.copyWith(
            kind: Wrapped.value(_kind),
            personal: Wrapped.value(game.copyPersonalWith(
              beaten: Wrapped.value(_personalBeaten),
              rating: Wrapped.value(_personalRating),
              timeSpent: Wrapped.value(_personalTimeSpent),
            )),
            howLongToBeat: Wrapped.value(game.copyHowLongToBeatWith(
              story: Wrapped.value(_howLongToBeatStory),
              storySides: Wrapped.value(_howLongToBeatStorySides),
              completionist: Wrapped.value(_howLongToBeatCompletionist),
            )),
            status: Wrapped.value(_status),
          ));
          Navigator.pop(context);
        },
        child: Text('Save'),
      )
    );

    return widgets;
  }

  Widget _buildFormRow(String label, Widget child, { bool expandChild = true }) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(label)),
        expandChild ? Expanded(flex: 3, child: child) : child,
      ] 
    );
  }

  Widget _buildActions(Game game) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 48),
          child: 
            CommandBar(
              mainAxisAlignment: MainAxisAlignment.end,
              primaryItems: [
                CommandBarButton(
                  icon: const Icon(FluentIcons.add),
                  label: const Text('Add Included Item'),
                  onPressed: () {
                    GameNavigator.goGameScreen(
                      context, 
                      parentId: game.id, 
                      status: GameStatus.backlog,
                    );
                  },
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.delete),
                  label: const Text('Delete'),
                  onPressed: () {
                    service.delete(game.id);
                    Navigator.pop(context);
                  },
                ),
              ],
            )
        )
      ]
    );
  }

  Game _initGame() {
    String? widgetId = widget.id;

    if (widgetId != null) {
      return service.get(widgetId)!;
    }

    Game game = Game.create(
      title: "New Game", 
      thumbUrl: null,
      status: widget.status,
      parentId: widget.parentId,
    );

    service.save(game);

    return game;
  }
}