import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/presentation/game/list.dart';
import 'package:gamorrah/presentation/game/navigator.dart';
import 'package:get/instance_manager.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({ 
    required this.status,
  });

  final GameStatus status;

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  late final GameService service;

  @override
  void initState() {
    super.initState();

    service = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: Text(_getTitle()),
        actions: _getActions(),
      ),
      content: ScaffoldPage(
        content: ListenableBuilder(
          listenable: service,
          builder: (context, innterWidget) {
            final games = service.getMainList(widget.status);

            if (games.isEmpty) {
              return Center(
                child: Text('Empty'),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: GameList(games: games),
            );
          },
        ),
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
                    GameNavigator.goGameScreen(context, status: widget.status);
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