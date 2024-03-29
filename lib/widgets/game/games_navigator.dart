import 'package:flutter/material.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/pages/games_page.dart';
import 'package:gamorrah/pages/game_page.dart';

class GamesNavigator extends StatelessWidget {
  const GamesNavigator({ 
    super.key, 
    required this.status,
  });

  final GameStatus status;
  
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings routeSettings) {
        return GamesNavigator.gamesRoute(status: status);
      }
    );
  }

  static void goGames(BuildContext context, { 
    required GameStatus status,
  }) {
    Navigator.push(context, gamesRoute(status: status));
  }

  static void goGame(BuildContext context, { required String id }) {
    Navigator.push(context, gameRoute(id: id));
  }

  static PageRoute gamesRoute({ 
    required GameStatus status,
  }) {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/games/$status'),
      builder: (context) {      
        return GamesPage(
          status: status,
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