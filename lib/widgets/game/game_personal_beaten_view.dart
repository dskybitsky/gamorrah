import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/widgets/ui/hspacer.dart';

class GamePersonalBeatenView extends StatelessWidget {
  const GamePersonalBeatenView({
    super.key,
    this.value,
    this.withIcon = true
  });

  final GamePersonalBeaten? value;
  final bool withIcon;
  
  @override
  Widget build(BuildContext context) {
    final icon = _getIcon();
    final text = _getText();

    if (icon != null && withIcon) {
      return Row(
        children:[icon, HSpacer(size: HSpacerSize.s), text]
      );
    }

    return text;
  }

  Text _getText() {
    switch (value) {
      case GamePersonalBeaten.bronze:
        return Text(t.types.gamePersonalBeaten.bronze);
      
      case GamePersonalBeaten.silver:
        return Text(t.types.gamePersonalBeaten.silver);

      case GamePersonalBeaten.gold:
        return Text(t.types.gamePersonalBeaten.gold);
      
      case GamePersonalBeaten.platinum:
        return Text(t.types.gamePersonalBeaten.platinum);
      
      default:
        return Text(t.types.gamePersonalBeaten.none);
    }
  }

  Icon? _getIcon() {
    switch (value) {
      case GamePersonalBeaten.bronze:
        return Icon(
          FluentIcons.medal,
          // color: Color(0xFFCD7F32)
        );
      
      case GamePersonalBeaten.silver:
        return Icon(
          FluentIcons.trophy,
            // color: Color(0xFFC0C0C0)
          );

      case GamePersonalBeaten.gold:
        return Icon(
          FluentIcons.trophy2,
            // color: Color(0xFFFFD700)
          );

      case GamePersonalBeaten.platinum:
        return Icon(
          FluentIcons.trophy2_solid,
          // color: Color(0xFFE5E4E2),
          // shadows: [Shadow(color: Colors.black)],
        );
      
      default:
        return null;
    }
  }
}