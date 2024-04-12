import 'package:flutter/material.dart';
import 'package:my_game_db/i18n/strings.g.dart';
import 'package:my_game_db/models/game/game.dart';
import 'package:my_game_db/models/optional.dart';
import 'package:my_game_db/widgets/ui/spacer.dart';
import 'package:my_game_db/widgets/ui/text_input_formats.dart';

class GameHowLongToBeatTile extends StatelessWidget {
  const GameHowLongToBeatTile({
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
            Flexible(child: TextFormField(
              initialValue: value.story?.toString(),
              inputFormatters: [TestInputFormats.hoursFormatter],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: t.types.gameHowLongToBeat.story,
              ),
              onChanged: _storyOnChanged,
            )),
            HSpacer(),
            Flexible(child: TextFormField(
              initialValue: value.storySides?.toString(),
              inputFormatters: [TestInputFormats.hoursFormatter],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: t.types.gameHowLongToBeat.storySides,
              ),
              onChanged: _storySidesOnChanged,
            )),
            HSpacer(),
            Flexible(child: TextFormField(
              initialValue: value.completionist?.toString(),
              inputFormatters: [TestInputFormats.hoursFormatter],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: t.types.gameHowLongToBeat.completionist,
              ),
              onChanged: _completionistOnChanged,
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

  void _storyOnChanged(String value) {
    if (onChanged != null) {
      onChanged!(this.value.copyWith(
        story: Optional(double.tryParse(value))
      ));
    }
  }

  void _storySidesOnChanged(value) {
    if (onChanged != null) {
      onChanged!(this.value.copyWith(
        storySides: Optional(double.tryParse(value))
      ));
    }
  }

  void _completionistOnChanged (value) {
    if (onChanged != null) {
      onChanged!(this.value.copyWith(
        completionist: Optional(double.tryParse(value))
      ));
    }
  }
}