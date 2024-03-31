import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_icon.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_text.dart';

class GamePersonalBeatenInput extends StatelessWidget {
  const GamePersonalBeatenInput({
    super.key,
    required this.value,
    this.onChanged,
    this.nullValueLabel
  });

  final GamePersonalBeaten? value;
  final void Function(GamePersonalBeaten?)? onChanged;
  final String? nullValueLabel;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<GamePersonalBeaten?>(
      label: Text(t.ui.gamePersonalControl.beatenLabel),
      initialSelection: value,
      expandedInsets: EdgeInsets.zero,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: null, 
          label: nullValueLabel ?? GamePersonalBeatenText.getString(null)
        ),
        ...GamePersonalBeaten.values.map((beaten) => DropdownMenuEntry(
            value: beaten, 
            leadingIcon: GamePersonalBeatenIcon(value: beaten),
            label: GamePersonalBeatenText.getString(beaten)
        )),
      ], 
      onSelected: (value) {
        onChanged!(value);
      }
    );
  }
}