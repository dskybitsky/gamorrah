import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/presentation/game/navigator.dart';
import 'package:gamorrah/presentation/game/thumb.dart';
import 'package:gamorrah/presentation/main_screen_context.dart';
import 'package:get/instance_manager.dart';

class GameGrid extends StatefulWidget {
  const GameGrid({ 
    required this.status,
  });

  final GameStatus status;

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> with MainScreenContextUpdateMixin {
  late final GameService service;
  late final Iterable<Game> games;

  @override
  void initState() {
    super.initState();

    service = Get.find();
    
    games = service.getAll()
      .where((element) => element.status == widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: ListenableBuilder(
        listenable: service,
        builder: (context, innterWidget) {
          updateScreenContext((mainScreenContext) {
            mainScreenContext.appBarTitleNotifier.value = _getTitle();
            mainScreenContext.appBarActionsNotifier.value = _getActions();
          });

          if (games.isEmpty) {
            return Center(
              child: Text('Empty'),
            );
          }

          return SingleChildScrollView(
            child: Wrap(
              spacing: 32.0, // gap between adjacent chips
              runSpacing: 16.0, // gap between lines
              children: games.map(
                (game) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GameThumb(
                      game: game,
                      size: GameThumbSize.medium,
                      onPressed: () {
                        GameNavigator.goGameForm(context, game.id);
                      },
                    ),
                  ]
                )
              ).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _getActions() {
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
                  label: const Text('Add New Game'),
                  onPressed: () {
                    GameNavigator.goGameForm(context, null);
                  },
                ),
              ],
            )
        )
      ]
    );
  }

  String _getTitle() {
    switch (widget.status) {
      case GameStatus.backlog:
        return 'Backlog';
      case GameStatus.playing:
        return 'Playing';
      case GameStatus.finished:
        return 'Finished';
      case GameStatus.wishlist:
        return 'Wishlist';
    }
  }
}