import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/widgets/ui/hspacer.dart';
import 'package:gamorrah/widgets/ui/space_size.dart';

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
              HSpacer(size: SpaceSize.s),
              Text(t.types.gameStatus.backlog),
            ]
          ),
        ),
        ComboBoxItem(
          value: GameStatus.playing, 
          child: Row(
            children: [
              const Icon(FluentIcons.play),
              HSpacer(size: SpaceSize.s),
              Text(t.types.gameStatus.playing),
            ]
          )
        ),
        ComboBoxItem(
          value: GameStatus.finished,
          child: Row(
            children: [
              const Icon(FluentIcons.completed),
              HSpacer(size: SpaceSize.s),
              Text(t.types.gameStatus.finished),
            ]
          )
        ),
        ComboBoxItem(
          value: GameStatus.wishlist,
          child: Row(
            children: [
              const Icon(FluentIcons.waitlist_confirm),
              HSpacer(size: SpaceSize.s),
              Text(t.types.gameStatus.wishlist),
            ]
          )
        ),
      ],
      onChanged: onChanged,
      isExpanded: true,
    );
  }
}