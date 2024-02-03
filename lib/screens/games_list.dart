import 'package:flutter/material.dart';
import 'package:gamorrah/models/game.dart';
import 'package:gamorrah/screens/game_form.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GamesListScreen extends StatefulWidget {
  @override
  State<GamesListScreen> createState() => _GamesListScreenState();
}

class _GamesListScreenState extends State<GamesListScreen> {
  late final Box<Game> gameBox;

  @override
  void initState() {
    super.initState();

    gameBox = Hive.box<Game>('games');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note List'),
      ),
      body: ValueListenableBuilder(
        valueListenable: gameBox.listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return Center(
              child: Text('Empty'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              Game game = gameBox.getAt(index)!;

                return ListTile(
                  title: Text(game.title),
                  subtitle: Text(game.thumbUrl ?? 'None'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Delete the note when the delete button is pressed.
                      gameBox.deleteAt(index);
                      setState(() {});
                    },
                  ),
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