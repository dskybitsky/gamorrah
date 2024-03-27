import 'package:flutter/material.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/widgets/game/game_status_icon.dart';
import 'package:gamorrah/widgets/game/game_status_text.dart';

class GameStatusInput extends StatelessWidget {
  const GameStatusInput({
    super.key,
    required this.value,
    this.onChanged,
  });

  final GameStatus? value;
  final void Function(GameStatus?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<GameStatus>(
      initialSelection: value,
      dropdownMenuEntries: GameStatus.values.map((status) => DropdownMenuEntry(
        value: GameStatus.backlog, 
        label: GameStatusText.getString(status),
        leadingIcon: GameStatusIcon(value: status),
      )).toList(),
      onSelected: onChanged,
    );
  }
}