import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_view.dart';

class GamePersonalBeatenInput extends StatelessWidget {
  const GamePersonalBeatenInput({
    super.key,
    required this.value,
    this.onChanged,
    this.emptyState
  });

  final GamePersonalBeaten? value;
  final void Function(GamePersonalBeaten?)? onChanged;
  final Widget? emptyState;

  @override
  Widget build(BuildContext context) {
    final emptyView = GamePersonalBeatenView(emptyState: emptyState);

    return ComboBox<GamePersonalBeaten?>(
      value: value,
      placeholder: emptyView,
      items: [
        ComboBoxItem(
          value: null, 
          child: emptyView,
        ),
        ComboBoxItem(
          value: GamePersonalBeaten.bronze, 
          child: GamePersonalBeatenView(value: GamePersonalBeaten.bronze),
        ),
        ComboBoxItem(
          value: GamePersonalBeaten.silver, 
          child: GamePersonalBeatenView(value: GamePersonalBeaten.silver),
        ),
        ComboBoxItem(
          value: GamePersonalBeaten.gold,
          child: GamePersonalBeatenView(value: GamePersonalBeaten.gold),
        ),
        ComboBoxItem(
          value: GamePersonalBeaten.platinum,
          child: GamePersonalBeatenView(value: GamePersonalBeaten.platinum),
        ),
      ],
      onChanged: onChanged,
      isExpanded: true,
    );
  }
}