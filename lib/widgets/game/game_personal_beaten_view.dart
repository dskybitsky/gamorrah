import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_icon.dart';
import 'package:gamorrah/widgets/ui/hspacer.dart';
import 'package:gamorrah/widgets/ui/space_size.dart';

class GamePersonalBeatenView extends StatelessWidget {
  const GamePersonalBeatenView({
    super.key,
    this.value,
    this.withIcon = true,
    this.withText = true,
    this.iconColor = Colors.black,
  });

  final GamePersonalBeaten? value;
  final bool withIcon;
  final bool withText;
  final Color iconColor;
  
  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    if (withIcon && value != null) {
      widgets.add(
        GamePersonalBeatenIcon(value: value!, color: iconColor)
      );
    }

    if (withText) {
      if (widgets.isNotEmpty) {
        widgets.add(HSpacer(size: SpaceSize.s));
      }

      widgets.add(_getText());
    }

    return Row(children: widgets);
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
}