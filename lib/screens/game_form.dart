import 'package:flutter/material.dart';
import 'package:gamorrah/models/game.dart';
import 'package:hive/hive.dart';

class GameFormScreen extends StatefulWidget {
  @override
  State<GameFormScreen> createState() => _GameFormScreenScreenState();
}

class _GameFormScreenScreenState extends State<GameFormScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  late Box<Game> gameBox;

  @override
  void initState() {
    super.initState();

    gameBox = Hive.box<Game>('games');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Create a new note and add it to the Hive box.
                final newGame = Game.create(
                  title: _titleController.text,
                  thumbUrl: _contentController.text,
                );
                
                gameBox.add(newGame);

                // Navigate back to the note list.
                Navigator.pop(context);
              },
              child: Text('Save Game'),
            ),
          ],
        ),
      ),
    );
  }
}