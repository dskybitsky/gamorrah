import 'package:flutter/material.dart';
import 'package:gamorrah/models/game.dart';
import 'package:gamorrah/models/game_service.dart';
import 'package:gamorrah/screens/game_form.dart';
import 'package:get/instance_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GamesListScreen extends StatefulWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Note List'),
      ),
      body: ValueListenableBuilder(
        valueListenable: service.listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return Center(
              child: Text('Empty'),
            );
          }

          var games = service.getAll();

          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              Game game = games.elementAt(index);

              return ListTile(
                title: Text(game.title),
                subtitle: Text(game.id),
                leading: game.thumbUrl != null ? Image.network(game.thumbUrl!) : null,
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    service.delete(game.id);
                  },
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => GameFormScreen(id: game.id)));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the note creation screen.
          Navigator.push(context, MaterialPageRoute(builder: (_) => GameFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}