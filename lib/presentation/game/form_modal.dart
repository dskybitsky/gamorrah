import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:get/instance_manager.dart';

class GameFormModal extends StatefulWidget {
  const GameFormModal({ required this.game });

  final Game game;

  @override
  State<GameFormModal> createState() => _GameFormModalScreenState();
}

class _GameFormModalScreenState extends State<GameFormModal> {
  late final GameService service;

  late TextEditingController _titleController;
  late TextEditingController _franchiseController;
  late TextEditingController _editionController;
  late int? _year;
  late TextEditingController _thumbUrlController;
  
  @override
  void initState() {
    super.initState();

    service = Get.find();

     _titleController = TextEditingController(text: widget.game.title);
     _franchiseController = TextEditingController(text: widget.game.franchise);
     _editionController = TextEditingController(text: widget.game.edition);
     _year = widget.game.year;
     _thumbUrlController = TextEditingController(text: widget.game.thumbUrl);
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      content: _buildDialogContent(context),
      actions: [
        Button(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        FilledButton(
          onPressed: () {
            service.save(widget.game.copyWith(
              title: _titleController.text,
              franchise: _franchiseController.text,
              edition: _editionController.text,
              year: _year,
              thumbUrl: _thumbUrlController.text,
            ));
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return ListView(
      children: [
        InfoLabel(
          label: 'Title:',
          child: TextBox(
            controller: _titleController,
            placeholder: 'Title',
            expands: false,
          ),
        ),
        SizedBox(height: 10),
        InfoLabel(
          label: 'Franchise:',
          child: TextBox(
            controller: _franchiseController,
            placeholder: 'Franchise Name',
            expands: false,
          ),
        ),
        SizedBox(height: 10),
        InfoLabel(
          label: 'Edition:',
          child: TextBox(
            controller: _editionController,
            placeholder: 'Edition',
            expands: false,
          ),
        ),
        SizedBox(height: 10),
        InfoLabel(
          label: 'Year:',
          child: NumberBox(
            placeholder: 'Year',
            value: _year,
            onChanged: (value) => { _year = value },
          ),
        ),
        SizedBox(height: 10),
        InfoLabel(
          label: 'Thumbnail URL:',
          child: TextBox(
            controller: _thumbUrlController,
            placeholder: 'URL',
            expands: false,
          ),
        ),
        
      ],
    );
  }
}