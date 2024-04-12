import 'package:flutter/material.dart';
import 'package:my_game_db/i18n/strings.g.dart';
import 'package:my_game_db/models/game/game.dart';
import 'package:my_game_db/widgets/game/game_status_icon.dart';

class GameStatusDropdown extends StatelessWidget {
  const GameStatusDropdown({
    super.key,
    required this.value,
    this.onChanged,
  });

  final GameStatus? value;
  final void Function(GameStatus?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<GameStatus>(
      label: Text(t.ui.gameStatusControl.titleLabel),
      initialSelection: value,
      expandedInsets: EdgeInsets.zero,
      dropdownMenuEntries: GameStatus.values.map((status) => DropdownMenuEntry(
        value: status, 
        label: t.types.gameStatus.values[status.name]!,
        leadingIcon: GameStatusIcon(value: status),
      )).toList(),
      onSelected: onChanged,
    );
  }
}