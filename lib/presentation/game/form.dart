import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/presentation/game/form_modal.dart';
import 'package:gamorrah/presentation/game/thumb.dart';
import 'package:get/instance_manager.dart';

class GameForm extends StatefulWidget {
  static const pageName = 'game';

  const GameForm({ required this.id });

  final String id;

  @override
  State<GameForm> createState() => _GameFormScreenState();
}

class _GameFormScreenState extends State<GameForm> {
  late final GameService service;

  GameStatus status = GameStatus.backlog;

  @override
  void initState() {
    super.initState();

    service = Get.find();

    Game game = service.get(widget.id)!;

    status = game.status;
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.id;

    return ListenableBuilder(
      listenable: service, 
      builder: (context, widget) {
        Game game = service.get(id)!;

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