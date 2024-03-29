import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/widgets/ui/spacer.dart';

class GameHowLongToBeatInput extends StatelessWidget {
  const GameHowLongToBeatInput({
    super.key,
    required this.value,
    this.onChanged,
  });

  final GameHowLongToBeat value;
  final void Function(GameHowLongToBeat)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(t.ui.gameHowLongToBeatControl.headerLabel),
      subtitle: _buildSubtitle(),
      children: [
        VSpacer(),
        TextField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            _onStoryChanged(double.parse(value));
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: t.types.gameHowLongToBeat.story,
          ),
        ),
        VSpacer(),
        TextField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            _onStorySidesChanged(double.parse(value));
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: t.types.gameHowLongToBeat.storySides,
          ),
        ),
        VSpacer(),
        TextField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            _onCompletionistChanged(double.parse(value));
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: t.types.gameHowLongToBeat.completionist,
          ),
        ),
        VSpacer(),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Row(
      children: [
        Text(t.ui.gameHowLongToBeatControl.storyLabel(count: value.story ?? "?")),
        HSpacer(),
        Text(t.ui.gameHowLongToBeatControl.storySidesLabel(count: value.storySides ?? "?")),
        HSpacer(),
        Text(t.ui.gameHowLongToBeatControl.completionistLabel(count: value.completionist ?? "?")),
        HSpacer(),
      ],
    );
  }

  void _onStoryChanged(double? story) {
    if (onChanged != null) {
      onChanged!(value.copyWith(story: Optional(story)));
    }
  }

  void _onStorySidesChanged(double? storySides) {
    if (onChanged != null) {
      onChanged!(value.copyWith(storySides: Optional(storySides)));
    }
  }

  void _onCompletionistChanged(double? completionist) {
    if (onChanged != null) {
      onChanged!(value.copyWith(completionist: Optional(completionist)));
    }
  }
}