import 'package:flutter/material.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/preferences/preferences.dart';
import 'package:gamorrah/pages/games_page.dart';
import 'package:gamorrah/pages/game_page.dart';

class GamesNavigator extends StatelessWidget {
  const GamesNavigator({ 
    super.key, 
    required this.status,
    this.presets = const []
  });

  final GameStatus status;
  final List<GamesPreset> presets;
  
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings routeSettings) {
        return GamesNavigator.gamesRoute(status: status, presets: presets);
      }
    );
  }

  static void goGames(BuildContext context, { 
    required GameStatus status,
    required List<GamesPreset> presets
  }) {
    Navigator.push(context, gamesRoute(status: status, presets: presets));
  }

  static void goGame(BuildContext context, { required String id }) {
    Navigator.push(context, gameRoute(id: id));
  }

  static PageRoute gamesRoute({ 
    required GameStatus status,
    required List<GamesPreset> presets
  }) {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/games/$status'),
      builder: (context) {      
        return GamesPage(
          status: status,
          presets: presets
        );
      }
    );
  }

  static PageRoute gameRoute({ required String id }) {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/game/$id'),
      builder: (context) {
        return GamePage(id: id);
      }
    );
  }
}