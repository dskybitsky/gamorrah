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

  String _filter = '';

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
      content: ListenableBuilder(
        listenable: service,
        builder: (context, innterWidget) {
          final games = service.getMainList(widget.status)
            .where((element) => _filter == '' || element.title.contains(RegExp(_filter, caseSensitive: false)))
            .toList();

          if (games.isEmpty) {
            return Center(
              child: Text('Empty'),
            );
          }

          return ScaffoldPage(
            content: SingleChildScrollView(
              padding: EdgeInsets.all(8.0),
              child: GameList(games: games),
            ),
            bottomBar: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: 8, bottom: 8, right: 24),
              child: Text(
                'Games total: ${games.length}',
                style: FluentTheme.of(context).typography.caption,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 196,
              child: TextBox(
                placeholder: "Filter",
                onChanged: (value) {
                  setState(() {
                    _filter = value;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                overflowBehavior: CommandBarOverflowBehavior.noWrap,
                primaryItems: [
                  CommandBarButton(
                    icon: const Icon(FluentIcons.add),
                    label: const Text('Add New Game'),
                    onPressed: () {
                      GameNavigator.goGameScreen(context, status: widget.status);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(width: 24),
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