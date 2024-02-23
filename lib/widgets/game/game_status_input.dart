import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';

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
    return ComboBox<GameStatus>(
      value: value,
      items: [
        ComboBoxItem(
          value: GameStatus.backlog, 
          child: Row(
            children: [
              const Icon(FluentIcons.history),
              const SizedBox(width: 8),
              const Text('Backlog'),
            ]
          ),
        ),
        ComboBoxItem(
          value: GameStatus.playing, 
          child: Row(
            children: [
              const Icon(FluentIcons.play),
              const SizedBox(width: 8),
              const Text('Playing'),
            ]
          )
        ),
        ComboBoxItem(
          value: GameStatus.finished,
          child: Row(
            children: [
              const Icon(FluentIcons.completed),
              const SizedBox(width: 8),
              const Text('Finished'),
            ]
          )
        ),
        ComboBoxItem(
          value: GameStatus.wishlist,
          child: Row(
            children: [
              const Icon(FluentIcons.waitlist_confirm),
              const SizedBox(width: 8),
              const Text('Wishlist'),
            ]
          )
        ),
      ],
      onChanged: onChanged,
      isExpanded: true,
    );
  }
}