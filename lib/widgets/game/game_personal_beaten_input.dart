import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';

class GamePersonalBeatenInput extends StatelessWidget {
  const GamePersonalBeatenInput({
    super.key,
    required this.value,
    this.onChanged,
  });

  final GamePersonalBeaten? value;
  final void Function(GamePersonalBeaten?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ComboBox<GamePersonalBeaten?>(
      value: value,
      placeholder: Text('No'),
      items: [
        ComboBoxItem(value: null, child: Text('No')),
        ComboBoxItem(
          value: GamePersonalBeaten.story, 
          child: Row(
            children: [
              const Icon(FluentIcons.check_mark),
              const SizedBox(width: 8),
              const Text('Story'),
            ]
          ),
        ),
        ComboBoxItem(
          value: GamePersonalBeaten.storySides, 
          child: Row(
            children: [
              const Icon(FluentIcons.check_list),
              const SizedBox(width: 8),
              const Text('Story + Sides'),
            ]
          ),
        ),
        ComboBoxItem(
          value: GamePersonalBeaten.completionist,
          child: Row(
            children: [
              const Icon(FluentIcons.medal),
              const SizedBox(width: 8),
              const Text('Completionist'),
            ]
          ),
        ),
      ],
      onChanged: onChanged,
      isExpanded: true,
    );
  }
}