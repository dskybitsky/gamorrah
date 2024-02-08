import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/presentation/game/form.dart';
import 'package:gamorrah/presentation/game/thumb.dart';
import 'package:gamorrah/presentation/main_screen.dart';
import 'package:get/instance_manager.dart';

class GameGrid extends StatefulWidget {
  const GameGrid({ 
    required this.status,
    required this.appBarParamsNotifier,
  });

  final GameStatus status;
  final ValueNotifier<MainScreenAppBarParams?> appBarParamsNotifier;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.appBarParamsNotifier.value = MainScreenAppBarParams( 
          title: _getTitle(),
          actions: Column(
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
                          Navigator.push(context, FluentPageRoute(builder: (_) => GameForm(
                            appBarParamsNotifier: widget.appBarParamsNotifier,
                          )));
                        },
                      ),
                      // CommandBarButton(
                      //   icon: const Icon(FluentIcons.delete),
                      //   label: const Text('Delete'),
                      //   onPressed: () {},
                      // ),
                    ],
                  )
              )
            ]
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: ListenableBuilder(
        listenable: service,
        builder: (context, innterWidget) {
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
                    Navigator.push(
                      context, 
                      FluentPageRoute(
                        builder: (_) => GameForm(
                          appBarParamsNotifier: widget.appBarParamsNotifier, 
                          id: game.id)),
                      );
                  },
                )
              )
            ).toList(),
          );

          // return ListView.builder(
          //   itemCount: games.length,
          //   itemBuilder: (context, index) {
          //     Game game = games.elementAt(index);
              
          //     return ListTile(
          //       title: Text(game.title),
          //       subtitle: Text(game.status.name),
          //       // leading: game.thumbUrl != null ? Image.network(game.thumbUrl!) : null,
          //       trailing: IconButton(
          //         icon: Icon(Icons.delete),
          //         onPressed: () {
          //           service.delete(game.id);
          //         },
          //       ),
          //       onTap: () {
          //         Navigator.push(context, MaterialPageRoute(builder: (_) => GameForm(id: game.id)));
          //       },
          //     );
          //   },
          // );
        },
      ),
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