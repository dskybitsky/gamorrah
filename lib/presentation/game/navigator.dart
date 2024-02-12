import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/game_screen.dart';
import 'package:gamorrah/presentation/game/games_screen.dart';

class GameNavigator extends StatelessWidget {
  const GameNavigator({ 
    super.key, 
    required this.navigatorKey, 
    required this.status,
  });

  final GameStatus status;
  final GlobalKey<NavigatorState> navigatorKey;
  
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings routeSettings) {
        return GameNavigator.gamesScreenRoute(status: status);
      }
    );
  }

  static void goGamesScreen(BuildContext context, { required GameStatus status }) {
    Navigator.push(context, gamesScreenRoute(status: status));
  }

  static void goGameScreen(BuildContext context, {
    String? id,
    GameStatus? status,
    String? parentId,
  }) {
    Navigator.push(context, gameScreenRoute(id: id, status: status, parentId: parentId));
  }

  static FluentPageRoute gamesScreenRoute({ required GameStatus status }) {
    return FluentPageRoute(
      builder: (context) {      
        return GamesScreen(
          status: status,
        );
      }
    );
  }

  static FluentPageRoute gameScreenRoute({
    String? id,
    GameStatus? status,
    String? parentId,
  }) {
    return FluentPageRoute(
      builder: (context) {      
        return GameScreen(
          id: id,
          status: status,
          parentId: parentId,
        );
      }
    );
  }
}