import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_view.dart';

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
      placeholder: GamePersonalBeatenView(),
      items: [
        ComboBoxItem(
          value: null, 
          child: GamePersonalBeatenView(),
        ),
        ComboBoxItem(
          value: GamePersonalBeaten.story, 
          child: GamePersonalBeatenView(value: GamePersonalBeaten.story),
        ),
        ComboBoxItem(
          value: GamePersonalBeaten.storySides, 
          child: GamePersonalBeatenView(value: GamePersonalBeaten.storySides),
        ),
        ComboBoxItem(
          value: GamePersonalBeaten.completionist,
          child: GamePersonalBeatenView(value: GamePersonalBeaten.completionist),
        ),
      ],
      onChanged: onChanged,
      isExpanded: true,
    );
  }
}