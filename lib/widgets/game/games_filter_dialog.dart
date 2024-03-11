import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/models/preferences/preferences.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_input.dart';
import 'package:gamorrah/widgets/game/game_platforms_input.dart';
import 'package:gamorrah/widgets/ui/vspacer.dart';

class GamesFilterDialog extends StatefulWidget {
  const GamesFilterDialog({
    required this.filter,
    this.onChanged,
  });

  final GamesFilter filter;
  final void Function(GamesFilter)? onChanged;

  @override
  State<GamesFilterDialog> createState() => _GamesFilterDialogState();
}

class _GamesFilterDialogState extends State<GamesFilterDialog> {
  late GamePersonalBeaten? _beaten;
  late Set<GamePlatform> _platforms;
  
  @override
  void initState() {
    super.initState();

    _beaten = widget.filter.beaten;
    _platforms = widget.filter.platforms != null
      ? Set.from(widget.filter.platforms!) 
      : {};
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
              final newFilter = widget.filter.copyWith(
                beaten: Optional(_beaten),
                platforms: Optional(_platforms.isEmpty ? null : _platforms)
              );

              onChanged(newFilter);
            }

            Navigator.pop(context);
          },
          child: Text(t.ui.general.okButton),
        ),
      ],
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return ListView(
      children: [
        InfoLabel(
          label: t.ui.gamePersonalControl.beatenLabel, 
          child: GamePersonalBeatenInput(
            value: _beaten,
            emptyState: Text(t.ui.general.anyText),
            onChanged: (value) {
              setState(() { 
                _beaten = value;
              });
            },
          )
        ),
        VSpacer(),
        InfoLabel(
          label: t.ui.gamePage.platformsLabel,
          child: GamePlatformsInput(
            value: _platforms,
            emptyState: Text(t.ui.general.anyText),
            onChanged: (value) {
              setState(() { 
                _platforms = value;
              });
            },
          ),
        ),
      ],
    );
  }
}