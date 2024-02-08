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
              thumbUrl: _thumbUrlController.text,
            ));
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );

    // return Container(
    //   padding: const EdgeInsets.all(96.0),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(16.0),
    //     color: theme.scaffoldBackgroundColor,
    //   ),
    //   child: ScaffoldPage(content: _buildForm(context)),
    // );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Column(
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
          label: 'Thumbnail URL:',
          child: TextBox(
            controller: _thumbUrlController,
            placeholder: 'URL',
            expands: false,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}