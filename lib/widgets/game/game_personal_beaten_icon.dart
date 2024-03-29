import 'package:flutter/material.dart';
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
        return Icon(Icons.check, color: color ?? Color(0xFFCD7F32));
      
      case GamePersonalBeaten.silver:
        return Icon(Icons.check, color: color ?? Color(0xFFC0C0C0));

      case GamePersonalBeaten.gold:
        return Icon(Icons.done_all, color: color ?? Color(0xFFFFD700));

      case GamePersonalBeaten.platinum:
        return Icon(Icons.verified, color: color ?? Color(0xFFE5E4E2));
    }
  }
}