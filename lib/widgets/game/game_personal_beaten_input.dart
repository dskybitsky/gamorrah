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
    this.enabled = true
  });

  final GamePersonalBeaten? value;
  final void Function(GamePersonalBeaten?)? onChanged;
  final bool enabled;
  
  @override
  Widget build(BuildContext context) {
    return DropdownMenu<GamePersonalBeaten?>(
      label: Text(t.ui.gamePersonalControl.beatenLabel),
      enabled: enabled,
      initialSelection: value,
      expandedInsets: EdgeInsets.zero,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: null, 
          label: GamePersonalBeatenText.getString(null)
        ),
        ...GamePersonalBeaten.values.map((beaten) => DropdownMenuEntry(
            value: beaten, 
            leadingIcon: GamePersonalBeatenIcon(value: beaten),
            label: GamePersonalBeatenText.getString(beaten)
        )),
      ], 
      onSelected: onChanged != null ? (value) {
        onChanged!(value);
      } : null
    );
  }
}