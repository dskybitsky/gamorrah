import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';

class GameStatusText extends StatelessWidget {
  const GameStatusText({
    super.key,
    required this.value,
  });

  final GameStatus value;

  static String getString(GameStatus value) {
    switch (value) {
      case GameStatus.backlog:
        return t.types.gameStatus.backlog;
      case GameStatus.playing:
        return t.types.gameStatus.playing;
      case GameStatus.finished:
        return t.types.gameStatus.finished;
      case GameStatus.wishlist:
        return t.types.gameStatus.wishlist;
    }
  }
  
  @override
  Widget build(BuildContext context) {
     return Text(getString(value));
  }
}