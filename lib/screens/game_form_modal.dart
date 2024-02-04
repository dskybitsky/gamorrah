import 'package:flutter/material.dart';
import 'package:gamorrah/models/game.dart';
import 'package:gamorrah/models/game_service.dart';
import 'package:get/instance_manager.dart';

class GameFormModal extends StatefulWidget {
  const GameFormModal({ required this.game });

  final Game game;

  @override
  State<GameFormModal> createState() => _GameFormModalScreenState();
}

class _GameFormModalScreenState extends State<GameFormModal> {
  late TextEditingController _titleController;
  late TextEditingController _thumbUrlController;

  late final GameService service;

  @override
  void initState() {
    super.initState();

    service = Get.find();

     _titleController = TextEditingController(text: widget.game.title);
     _thumbUrlController = TextEditingController(text: widget.game.thumbUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                service.save(widget.game.copyWith(
                  title: _titleController.text,
                  thumbUrl: _thumbUrlController.text,
                ));
                setState(() {
                  
                });
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}