import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/presentation/game/form_modal.dart';
import 'package:gamorrah/presentation/game/thumb.dart';
import 'package:gamorrah/presentation/main_screen.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class GameForm extends StatefulWidget {
  const GameForm({ 
    required this.appBarParamsNotifier,
    this.id,
  });

  final String? id;
  final ValueNotifier<MainScreenAppBarParams?> appBarParamsNotifier;

  @override
  State<GameForm> createState() => _GameFormScreenState();
}

class _GameFormScreenState extends State<GameForm> {
  late final String id;
  late final GameService service;
  late final GameStatus status;

  @override
  void initState() {
    super.initState();

    service = Get.find();

    Game game = _initGame();

    id = game.id;
    status = game.status;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.appBarParamsNotifier.value = MainScreenAppBarParams( 
          title: game.title,
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
          ),
        );
      }
    });
  }

  Game _initGame() {
    String? widgetId = widget.id;

    if (widgetId != null) {
      return service.get(widgetId)!;
    }

    Game game = Game.create(title: "New Game", thumbUrl: null);

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

        return ScaffoldPage(
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GameThumb(
                  game: game,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => GameFormModal(game: game),
                    );
                  }
                ),
                SizedBox(height: 16),
                ComboBox<GameStatus>(
                  value: status,
                  items: [
                    ComboBoxItem(value: GameStatus.backlog, child: Text('Backlog')),
                    ComboBoxItem(value: GameStatus.playing, child: Text("Playing")),
                    ComboBoxItem(value: GameStatus.finished, child: Text("Finished")),
                    ComboBoxItem(value: GameStatus.wishlist, child: Text("Wishlist")),
                  ],
                  onChanged: ( value) {
                    setState(() {
                      status = value ?? GameStatus.backlog;
                    });
                  },
                ),
                Button(
                  onPressed: () {
                    service.save(game.copyWith(
                      status: status
                    ));
                    
                    Navigator.pop(context);
                  },
                  child: Text('Save Game'),
                ),
              ],
            ),
          ),
        ); 
      }
    );
  }
}