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

class _GameGridState extends State<GameGrid> {
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
          print('Grid builder called');
            
          WidgetsBinding.instance.addPostFrameCallback((_) {
            MainScreenContext mainScreenContext = MainScreenContext.of(context);

            if (mounted) {
              mainScreenContext.appBarTitleNotifier.value = _getTitle();
              mainScreenContext.appBarActionsNotifier.value = _getActions();
            }
          });

          if (games.isEmpty) {
            return Center(
              child: Text('Empty'),
            );
          }

          return GridView.count(
            crossAxisCount: 2,
            children: games.map(
              (game) => Card(
                child: GameThumb(
                  game: game,
                  onPressed: () {
                    GameNavigator.goGameForm(context, game.id);
                  },
                )
              )
            ).toList(),
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
                  label: const Text('Create'),
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