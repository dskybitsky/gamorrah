import 'package:flutter/material.dart';
import 'package:gamorrah/components/game_thumb.dart';
import 'package:gamorrah/models/game.dart';
import 'package:gamorrah/models/game_service.dart';
import 'package:gamorrah/screens/game_form_modal.dart';
import 'package:get/instance_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GameFormScreen extends StatefulWidget {
  const GameFormScreen({ this.id });

  final String? id;

  @override
  State<GameFormScreen> createState() => _GameFormScreenScreenState();
}

class _GameFormScreenScreenState extends State<GameFormScreen> {
  late final GameService service;
  late final Game originalGame;

  Game? _getGame(String? id) {
    return id != null 
        ? service.get(id)
        : null;
  }

  Game _createDefaultGame() {
    Game game = Game.create(title: "New Game", thumbUrl: null);

    service.save(game);

    return game;
  }

  @override
  void initState() {
    super.initState();

    service = Get.find();

    originalGame = _getGame(widget.id) ?? _createDefaultGame();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: service.listenable(), 
      builder: (context, Box box, widget) {
        Game game = _getGame(originalGame.id)!;

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
                ElevatedButton(
                  onPressed: () {
                    // service.save(Game.create(
                    //   id: game.id,
                    //   title: _titleController.text,
                    //   thumbUrl: _thumbUrlController.text,
                    // ));
                    
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