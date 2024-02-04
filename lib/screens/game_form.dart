import 'package:flutter/material.dart';
import 'package:gamorrah/components/game_thumb.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/screens/game_form_modal.dart';
import 'package:get/instance_manager.dart';

class GameFormScreen extends StatefulWidget {
  const GameFormScreen({ required this.id });

  final String id;

  @override
  State<GameFormScreen> createState() => _GameFormScreenScreenState();
}

class _GameFormScreenScreenState extends State<GameFormScreen> {
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

        return Scaffold(
          appBar: AppBar(
            title: Text(game.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GameThumb(
                  game: game,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => GameFormModal(game: game),
                    );
                  }
                ),
                SizedBox(height: 16),
                DropdownButton<GameStatus>(
                  value: status,
                  items: [
                    DropdownMenuItem(value: GameStatus.backlog, child: Text('Backlog')),
                    DropdownMenuItem(value: GameStatus.playing, child: Text("Playing")),
                    DropdownMenuItem(value: GameStatus.finished, child: Text("Finished")),
                    DropdownMenuItem(value: GameStatus.wishlist, child: Text("Wishlist")),
                  ],
                  onChanged: ( value) {
                    setState(() {
                      status = value ?? GameStatus.backlog;
                    });
                  },
                ),
                ElevatedButton(
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