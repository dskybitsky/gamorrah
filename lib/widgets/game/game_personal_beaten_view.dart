import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';

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
        children:[icon, SizedBox(width: 8), text]
      );
    }

    return text;
  }

  Text _getText() {
    switch (value) {
      case GamePersonalBeaten.story:
        return Text(t.types.gamePersonalBeaten.story);
      
      case GamePersonalBeaten.storySides:
        return Text(t.types.gamePersonalBeaten.storySides);

      case GamePersonalBeaten.completionist:
        return Text(t.types.gamePersonalBeaten.completionist);
      
      default:
        return Text(t.types.gamePersonalBeaten.none);
    }
  }

  Icon? _getIcon() {
    switch (value) {
      case GamePersonalBeaten.story:
        return Icon(FluentIcons.check_mark);
      
      case GamePersonalBeaten.storySides:
        return Icon(FluentIcons.check_list);

      case GamePersonalBeaten.completionist:
        return Icon(FluentIcons.medal);
      
      default:
        return null;
    }
  }
}