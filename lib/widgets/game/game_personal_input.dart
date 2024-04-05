import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_input.dart';
import 'package:gamorrah/widgets/game/game_personal_rating_input.dart';
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
      title: Text(t.ui.gamePersonalControl.headerLabel),
      subtitle: _buildSubtitle(context),
      children: [
        VSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: GamePersonalBeatenInput(
              value: value.beaten, 
              onChanged: _onBeatenChanged,
            )),
            HSpacer(),
            Flexible(child: TextField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                _onTimeSpentChanged(double.parse(value));
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: t.ui.gamePersonalControl.timeSpentLabel,
              ),
            ))
          ],
        ),
        VSpacer(),
        ListTile(
          title: Text(t.ui.gamePersonalControl.ratingLabel),
          trailing: GamePersonalRatingInput(
            value: value.rating, 
            onChanged: _onRatingChanged,
          ),
        ),
        VSpacer(),
      ],
    );
  }
  
  Widget _buildSubtitle(BuildContext context) {
    final beaten = value.beaten;

    var widgets = <Widget>[
        Text(
          beaten != null 
            ? t.types.gamePersonalBeaten.values[beaten.name]!
            : t.types.gamePersonalBeaten.none
        )
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