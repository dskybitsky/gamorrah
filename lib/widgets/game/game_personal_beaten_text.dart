import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';

class GamePersonalBeatenText extends StatelessWidget {
  const GamePersonalBeatenText({
    super.key,
    required this.value,
  });

  final GamePersonalBeaten value;

  static String getString(GamePersonalBeaten value) {
    switch (value) {
      case GamePersonalBeaten.bronze:
        return t.types.gamePersonalBeaten.bronze;
      
      case GamePersonalBeaten.silver:
        return t.types.gamePersonalBeaten.silver;

      case GamePersonalBeaten.gold:
        return t.types.gamePersonalBeaten.gold;
      
      case GamePersonalBeaten.platinum:
        return t.types.gamePersonalBeaten.platinum;
    }
  }
  
  @override
  Widget build(BuildContext context) {
     return Text(getString(value));
  }
}