import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/navigator.dart';
import 'package:gamorrah/presentation/game/thumb.dart';

class GameList extends StatelessWidget {
  const GameList({ 
    required this.games,
    this.thumbSize = GameThumbSize.medium,
  });

  final Iterable<Game> games;
  final GameThumbSize thumbSize;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 32.0, // gap between adjacent chips
      runSpacing: 16.0, // gap between lines
      children: games.map(
        (game) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GameThumb(
              game: game,
              size: thumbSize,
              onPressed: () {
                GameNavigator.goGameForm(context, id: game.id);
              },
            ),
          ]
        )
      ).toList(),
    );
  }
}