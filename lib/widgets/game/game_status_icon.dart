import 'package:flutter/material.dart';
import 'package:my_game_db/models/game/game.dart';

class GameStatusIcon extends StatelessWidget {
  const GameStatusIcon({
    super.key,
    required this.value,
    this.color,
  });

  final GameStatus value;
  final Color? color;
  
  @override
  Widget build(BuildContext context) {
    switch (value) {
      case GameStatus.backlog:
        return Icon(Icons.history, color: color);
      
      case GameStatus.playing:
        return Icon(Icons.play_arrow, color: color);

      case GameStatus.finished:
        return Icon(Icons.done, color: color);
      
      case GameStatus.wishlist:
        return Icon(Icons.redeem, color: color);
    }
  }
}