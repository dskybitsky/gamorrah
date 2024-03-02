import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';

class GamePersonalBeatenIcon extends StatelessWidget {
  const GamePersonalBeatenIcon({
    super.key,
    required this.value,
    this.color,
  });

  final GamePersonalBeaten value;
  final Color? color;
  
  @override
  Widget build(BuildContext context) {
    switch (value) {
      case GamePersonalBeaten.bronze:
        return Icon(
          FluentIcons.medal,
          color: color ?? Color(0xFFCD7F32)
        );
      
      case GamePersonalBeaten.silver:
        return Icon(
          FluentIcons.trophy,
            color: color ?? Color(0xFFC0C0C0)
          );

      case GamePersonalBeaten.gold:
        return Icon(
          FluentIcons.trophy2,
            color: color ?? Color(0xFFFFD700)
          );

      case GamePersonalBeaten.platinum:
        return Icon(
          FluentIcons.trophy2_solid,
          color: color ?? Color(0xFFE5E4E2),
        );
    }
  }
}