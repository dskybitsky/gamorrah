import 'package:flutter/material.dart';
import 'package:my_game_db/i18n/strings.g.dart';
import 'package:my_game_db/models/game/game.dart';
import 'package:my_game_db/widgets/game/game_personal_beaten_icon.dart';

class GamePersonalBeatenDropdown extends StatelessWidget {
  const GamePersonalBeatenDropdown({
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
          label: t.types.gamePersonalBeaten.none
        ),
        ...GamePersonalBeaten.values.map((beaten) => DropdownMenuEntry(
            value: beaten, 
            leadingIcon: GamePersonalBeatenIcon(value: beaten),
            label: t.types.gamePersonalBeaten.values[beaten.name]!
        )),
      ], 
      onSelected: onChanged != null ? (value) {
        onChanged!(value);
      } : null
    );
  }
}