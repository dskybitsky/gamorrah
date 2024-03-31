import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/games_view/games_view.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_input.dart';
import 'package:gamorrah/widgets/game/game_platforms_input.dart';
import 'package:gamorrah/widgets/ui/spacer.dart';

class GamesPageFilterDialog extends StatefulWidget {
  const GamesPageFilterDialog({
    this.filter,
    this.onChanged,
  });

  final GamesFilter? filter;
  final void Function(GamesFilter)? onChanged;

  @override
  State<GamesPageFilterDialog> createState() => _GamesPageFilterDialogState();
}

class _GamesPageFilterDialogState extends State<GamesPageFilterDialog> {
  late GamePersonalBeaten? _beaten;
  late Set<GamePlatform> _platforms;
  
  @override
  void initState() {
    super.initState();

    _beaten = widget.filter?.beaten;
    _platforms = widget.filter?.platforms != null
      ? Set.from(widget.filter!.platforms!) 
      : {};
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.ui.gamesPage.filterDialogTitle),
      content: _buildContent(context),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.ui.general.cancelButton),
        ),
        TextButton(
          onPressed: () {
            final onChanged = widget.onChanged;

            if (onChanged != null) {
              final platforms = _platforms.isEmpty ? null : _platforms;

              final newFilter = widget.filter != null
                ? widget.filter!.copyWith(
                    beaten: Optional(_beaten),
                    platforms: Optional(platforms)
                  )
                : GamesFilter(
                  beaten: _beaten, 
                  platforms: platforms
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

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GamePersonalBeatenInput(
            value: _beaten,
            nullValueLabel: t.ui.general.anyText,
            onChanged: (value) {
              setState(() { 
                _beaten = value;
              });
            },
          ),
          VSpacer(),
          GamePlatformsInput(
            value: _platforms,
            onChanged: (value) {
              setState(() {
                _platforms = value;
              });
            },
          ),
        ],
      ),
    );
  }
}