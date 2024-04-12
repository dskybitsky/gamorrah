import 'package:flutter/material.dart';
import 'package:my_game_db/models/game/game.dart';
import 'package:my_game_db/widgets/game/game_thumb.dart';
import 'package:my_game_db/widgets/game/games_navigator.dart';
import 'package:reorderables/reorderables.dart';

class GamesList extends StatelessWidget {
  const GamesList({ 
    required this.games,
    this.thumbType = GameThumbType.medium,
    this.onReorder,
  });

  final Iterable<Game> games;
  final GameThumbType thumbType;
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
              type: thumbType,
              onPressed: () {
                GamesNavigator.goGame(context, id: game.id);
              },
            ),
          ]
        )
      ).toList();
  }
}