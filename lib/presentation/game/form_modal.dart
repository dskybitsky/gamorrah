import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:get/get.dart';
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
  late Set<GamePlatform> _platforms;
  
  @override
  void initState() {
    super.initState();

    service = Get.find();

     _titleController = TextEditingController(text: widget.game.title);
     _franchiseController = TextEditingController(text: widget.game.franchise);
     _editionController = TextEditingController(text: widget.game.edition);
     _year = widget.game.year;
     _thumbUrlController = TextEditingController(text: widget.game.thumbUrl);
     _platforms = Set.from(widget.game.platforms);
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
              platforms: _platforms,
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
        SizedBox(height: 16),
        InfoLabel(
          label: 'Franchise:',
          child: TextBox(
            controller: _franchiseController,
            placeholder: 'Franchise Name',
            expands: false,
          ),
        ),
        SizedBox(height: 16),
        InfoLabel(
          label: 'Edition:',
          child: TextBox(
            controller: _editionController,
            placeholder: 'Edition',
            expands: false,
          ),
        ),
        SizedBox(height: 16),
        InfoLabel(
          label: 'Year:',
          child: NumberBox(
            placeholder: 'Year',
            value: _year,
            onChanged: (value) => { _year = value },
          ),
        ),
        SizedBox(height: 16),
        InfoLabel(
          label: 'Thumbnail URL:',
          child: TextBox(
            controller: _thumbUrlController,
            placeholder: 'URL',
            expands: false,
          ),
        ),
        SizedBox(height: 16),
        InfoLabel(
          label: 'Platforms:',
          child: Expander(
            header: Wrap(
              children: _platforms
                .map((e) => Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: Text(
                    '${e.title}; ',
                    style: FluentTheme.of(context).typography.caption
                  ),
                )).toList(),
            ),
            content:
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: GamePlatform.values
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                            child: Checkbox(
                              checked: _platforms.contains(e),
                              onChanged: (selected) {
                                if (selected == true) { 
                                  setState(() => _platforms.add(e));
                                } else {
                                  setState(() => _platforms.remove(e));
                                }
                              },
                              content: Text(e.title),
                            ),
                          ),
                        )
                        .toList(),
                  ),
            ]),
          ),
        ),
      ],
    );
  }
}