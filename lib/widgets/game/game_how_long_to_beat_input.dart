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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: TextField(
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
            )),
            HSpacer(),
            Flexible(child: TextField(
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
            )),
            HSpacer(),
            Flexible(child: TextField(
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
            )),
          ],
        ),
        VSpacer(),
      ],
    );
  }

  Widget _buildSubtitle() {
    final List<Widget> widgets = [];

    if (value.story != null) {
      widgets.add(Text(t.ui.gameHowLongToBeatControl.storyLabel(count: value.story!)));
    }
    
    if (value.storySides != null) {
      widgets.add(Text(t.ui.gameHowLongToBeatControl.storySidesLabel(count: value.storySides!)));
    }

    if (value.completionist != null) {
      widgets.add(Text(t.ui.gameHowLongToBeatControl.completionistLabel(count: value.completionist!)));
    }

    if (widgets.isEmpty) {
      widgets.add(Text(t.ui.general.noText));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets
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