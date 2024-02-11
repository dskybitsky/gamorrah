import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
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
  late final List<Game> includedGames;

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

    includedGames = service.getAll()
      .where((nestedGame) => nestedGame.parentId == game.id)
      .toList();

    includedGames
      .sort((gameA, gameB) => (gameA.index ?? 0).compareTo(gameB.index ?? 0));
    
    _personalBeaten = game.personal?.beaten;
    _personalRating = game.personal?.rating;
    _personalTimeSpent = game.personal?.timeSpent;

    _howLongToBeatStory = game.howLongToBeat?.story;
    _howLongToBeatStorySides = game.howLongToBeat?.storySides;
    _howLongToBeatCompletionist = game.howLongToBeat?.completionist;

    _status = game.status;
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
                  Expanded(flex: 3, child: _buildForm(game)),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
          )
        ); 
      }
    );
  }

  Widget _buildForm(Game game) {
    return ListView(
      padding: EdgeInsets.only(left: 16, right: 16),
      children: [
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
        ),
        SizedBox(height: 32),
        Center(child: GameList(games: includedGames, thumbSize: GameThumbSize.small)),
        SizedBox(height: 32),
        Container(
          alignment: Alignment.centerLeft, 
          child: Text('PERSONAL'),
        ),
        SizedBox(height: 16),
        _buildFormRow('Beaten:', ComboBox<GamePersonalBeaten>(
            value: _personalBeaten,
            items: [
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
          )),
        SizedBox(height: 16),
        _buildFormRow('Rating:', NumberBox(
          placeholder: 'Rating',
          value: _personalRating,
          onChanged: (value) => { _personalRating = value },
        )),
        SizedBox(height: 16),
        _buildFormRow('Time Spent:', NumberBox(
          placeholder: 'Hours',
          value: _personalTimeSpent,
          onChanged: (value) => { _personalTimeSpent = value },
        )),
        SizedBox(height: 32),
        Container(
          alignment: Alignment.centerLeft, 
          child: Text('HOWLONGTOBEAT'),
        ),
        SizedBox(height: 16),
        _buildFormRow('Story:', NumberBox(
          placeholder: 'Hours',
          value: _howLongToBeatStory,
          onChanged: (value) => { _howLongToBeatStory = value },
        )),
        SizedBox(height: 16),
        _buildFormRow('Story + Sides:', NumberBox(
          placeholder: 'Hours',
          value: _howLongToBeatStorySides,
          onChanged: (value) => { _howLongToBeatStorySides = value },
        )),
        SizedBox(height: 16),
        _buildFormRow('Completionist:', NumberBox(
          placeholder: 'Hours',
          value: _howLongToBeatCompletionist,
          onChanged: (value) => { _howLongToBeatCompletionist = value },
        )),
        SizedBox(height: 32),
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
        )),
        SizedBox(height: 32),
        FilledButton(
          onPressed: () {
            service.save(game.copyWith(
              status: _status,
              personal: game.copyPersonalWith(
                beaten: _personalBeaten,
                rating: _personalRating,
                timeSpent: _personalTimeSpent,
              ),
              howLongToBeat: game.copyHowLongToBeatWith(
                story: _howLongToBeatStory,
                storySides: _howLongToBeatStorySides,
                completionist: _howLongToBeatCompletionist,
              )
            ));
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  Widget _buildFormRow(String label, Widget child) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(label)),
        Expanded(flex: 3, child: child),
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
}