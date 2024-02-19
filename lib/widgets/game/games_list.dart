import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/widgets/game/game_thumb.dart';
import 'package:gamorrah/widgets/game/games_navigator.dart';
import 'package:reorderables/reorderables.dart';

class GamesList extends StatelessWidget {
  const GamesList({ 
    required this.games,
    this.thumbSize = GameThumbSize.medium,
    this.onReorder,
  });

  final Iterable<Game> games;
  final GameThumbSize thumbSize;
  final Function(int, int)? onReorder;

  @override
  Widget build(BuildContext context) {
    if (onReorder != null) {
      return ReorderableWrap(
        spacing: 32.0,
        runSpacing: 24.0,
        onReorder: onReorder!,
        children: _buildChildren(context), 
      );
    }

    return Wrap(
      spacing: 32.0,
      runSpacing: 32.0,
      children: _buildChildren(context),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    return games.map(
        (game) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GameThumb(
              game: game,
              size: thumbSize,
              onPressed: () {
                GamesNavigator.goGame(context, id: game.id);
              },
            ),
          ]
        )
      ).toList();
  }
}