import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_input.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_text.dart';
import 'package:gamorrah/widgets/game/game_personal_rating_input.dart';
import 'package:gamorrah/widgets/ui/labeled_input.dart';
import 'package:gamorrah/widgets/ui/spacer.dart';

class GamePersonalInput extends StatelessWidget {
  const GamePersonalInput({
    super.key,
    required this.value,
    this.onChanged,
  });

  final GamePersonal value;
  final void Function(GamePersonal)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildHeader(context),
      children: [
        LabeledInput(
          label: Text(t.ui.gamePersonalControl.beatenLabel), 
          child: GamePersonalBeatenInput(
            value: value.beaten, 
            onChanged: _onBeatenChanged,
          )
        ),
        VSpacer(),
        LabeledInput(
          label: Text(t.ui.gamePersonalControl.ratingLabel), 
          child: GamePersonalRatingInput(
            value: value.rating, 
            onChanged: _onRatingChanged,
          )
        ),
        VSpacer(),
        // LabeledInput(
        //   label: Text(t.ui.gamePersonalControl.timeSpentLabel), 
        //   child: NumberBox(
        //     placeholder: t.ui.general.hoursText,
        //     value: value.timeSpent,
        //     onChanged: _onTimeSpentChanged
        //   )),
      ],
    );
  }
  
  Widget _buildHeader(BuildContext context) {
    var widgets = <Widget>[
        Text(t.ui.gamePersonalControl.headerLabel),
        HSpacer(),
        value.beaten != null 
          ? GamePersonalBeatenText(value: value.beaten!)
          : Text(t.types.gamePersonalBeaten.none)
        // GamePersonalBeatenView(value: value.beaten)
    ];

    final timeSpent = value.timeSpent;

    if (timeSpent != null) {
      widgets.add(HSpacer(size: SpaceSize.s));
      widgets.add(Text(t.ui.general.hoursCountText(count: timeSpent)));
    }

    return Row(children: widgets);
  }

  void _onBeatenChanged(GamePersonalBeaten? beaten) {
    if (onChanged != null) {
      onChanged!(value.copyWith(beaten: Optional(beaten)));
    }
  }

  void _onRatingChanged(double? rating) {
    if (onChanged != null) {
      onChanged!(value.copyWith(rating: Optional(rating)));
    }
  }

  void _onTimeSpentChanged(double? timeSpent) {
    if (onChanged != null) {
      onChanged!(value.copyWith(timeSpent: Optional(timeSpent)));
    }
  }
}