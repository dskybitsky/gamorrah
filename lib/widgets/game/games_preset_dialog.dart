import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/i18n/strings.g.dart';

class GamesPresetDialog extends StatefulWidget {
  const GamesPresetDialog({
    this.onChanged,
  });

  final void Function(String)? onChanged;

  @override
  State<GamesPresetDialog> createState() => _GamesPresetDialogState();
}

class _GamesPresetDialogState extends State<GamesPresetDialog> {
  late TextEditingController _nameController;
  
  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: 'New Preset');
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      content: _buildDialogContent(context),
      actions: [
        Button(
          child: Text(t.ui.general.cancelButton),
          onPressed: () => Navigator.pop(context),
        ),
        FilledButton(
          onPressed: () {
            final onChanged = widget.onChanged;

            if (onChanged != null) {
              onChanged(_nameController.text);
            }
            
            Navigator.pop(context);
          },
          child: Text(t.ui.general.saveButton),
        ),
      ],
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return ListView(
      children: [
       InfoLabel(
          label: t.ui.gamesPage.presetNameLabel,
          child: TextBox(
            controller: _nameController,
            placeholder: t.ui.gamePage.titlePlaceholder,
            expands: false,
          ),
        ),
      ],
    );
  }
}