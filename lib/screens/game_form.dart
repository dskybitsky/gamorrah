import 'package:flutter/material.dart';
import 'package:gamorrah/models/game.dart';
import 'package:gamorrah/models/game_service.dart';
import 'package:get/instance_manager.dart';

class GameFormScreen extends StatefulWidget {
  const GameFormScreen({ this.id });

  final String? id;

  @override
  State<GameFormScreen> createState() => _GameFormScreenScreenState();
}

class _GameFormScreenScreenState extends State<GameFormScreen> {
  late TextEditingController _titleController;
  late TextEditingController _thumbUrlController;

  late final GameService service;
  late Game game;

  @override
  void initState() {
    super.initState();

    service = Get.find();
    
    game = (
      widget.id != null 
        ? service.get(widget.id!)
        : null
    ) ?? Game.create(title: "New Game", thumbUrl: null);

     _titleController = TextEditingController(text: game.title);
     _thumbUrlController = TextEditingController(text: game.thumbUrl);
  }

  @override
  Widget build(BuildContext context) {
    bool _validThumbURL = Uri.parse(_thumbUrlController.text).isAbsolute;

    return Scaffold(
      appBar: AppBar(
        title: Text('${game.title}: ${widget.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _validThumbURL 
            ? Image.network(_thumbUrlController.text) 
            : Container(),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _thumbUrlController,
              decoration: InputDecoration(labelText: 'Thumbnail URL'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                service.save(Game.create(
                  id: game.id,
                  title: _titleController.text,
                  thumbUrl: _thumbUrlController.text,
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
}