import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/widgets/ui/labeled_input.dart';
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
      title: _buildHeader(),
      children: [
        LabeledInput(
          label: Text(t.types.gameHowLongToBeat.story),
          child: TextField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              _onStoryChanged(double.parse(value));
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: t.ui.general.hoursText,
            ),
          )
        ),
        // VSpacer(),
        // LabeledInput(
        //   label: Text(t.types.gameHowLongToBeat.storySides),
        //   child: NumberBox(
        //     placeholder: t.ui.general.hoursText,
        //     value: value.storySides,
        //     onChanged: _onStorySidesChanged,
        //   )
        // ),
        // VSpacer(),
        // LabeledInput(
        //   label: Text(t.types.gameHowLongToBeat.completionist),
        //   child: NumberBox(
        //     placeholder: t.ui.general.hoursText,
        //     value: value.completionist,
        //     onChanged: _onCompletionistChanged,
        //   )
        // ),
      ],
    );
  }

  Widget _buildHeader() {
    final widgets = <Widget>[
      Text(t.ui.gameHowLongToBeatControl.headerLabel),
      HSpacer(),
    ];

    final story = value.story;

    if (story != null) {
      widgets.add(Text(t.ui.gameHowLongToBeatControl.storyLabel(
        count: story
      )));
      widgets.add(HSpacer(size: SpaceSize.s));
    }

    final storySides = value.storySides;

    if (storySides != null) {
      widgets.add(Text(t.ui.gameHowLongToBeatControl.storySidesLabel(
        count: storySides
      )));
      widgets.add(HSpacer(size: SpaceSize.s));
    }

    final completionist = value.completionist;

    if (completionist != null) {
      widgets.add(Text(t.ui.gameHowLongToBeatControl.completionistLabel(
        count: completionist
      )));
      widgets.add(HSpacer(size: SpaceSize.s));
    }

    return Row(children: widgets);
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