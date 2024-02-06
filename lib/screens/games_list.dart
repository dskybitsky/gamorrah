import 'package:flutter/material.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/screens/game_form.dart';
import 'package:get/instance_manager.dart';

class GamesListScreen extends StatefulWidget {
  static const pageName = 'games';

  final GameStatus status;
  final Function? toolbarBuilder;

  const GamesListScreen({ 
    required this.status,
    this.toolbarBuilder,
  });

  @override
  State<GamesListScreen> createState() => _GamesListScreenState();
}

class _GamesListScreenState extends State<GamesListScreen> {
  late final GameService service;

  @override
  void initState() {
    super.initState();

    service = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    GameStatus status = widget.status;

    return Scaffold(
      body: ListenableBuilder(
        listenable: service,
        builder: (context, widget) {
          var games = service.getAll()
            .where((element) => element.status == status);
          
          if (games.isEmpty) {
            return Center(
              child: Text('Empty'),
            );
          }

          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              Game game = games.elementAt(index);
              
              return ListTile(
                title: Text(game.title),
                subtitle: Text(game.status.name),
                // leading: game.thumbUrl != null ? Image.network(game.thumbUrl!) : null,
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    service.delete(game.id);
                  },
                ),
                onTap: () {
                  // Navigator.pushNamed(context, 'game', arguments: game.id);
                  
                  Navigator.push(context, MaterialPageRoute(builder: (_) => GameFormScreen(id: game.id)));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Game game = Game.create(title: "New Game", thumbUrl: null);

          service.save(game);

          Navigator.push(context, MaterialPageRoute(builder: (_) => GameFormScreen(id: game.id)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}