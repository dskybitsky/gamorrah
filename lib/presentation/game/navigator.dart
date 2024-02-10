import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/form.dart';
import 'package:gamorrah/presentation/game/grid.dart';

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
        return GameNavigator.gameGridRoute(status: status);
      }
    );
  }

  static void goGameGrid(BuildContext context, { required GameStatus status }) {
    Navigator.push(context, gameGridRoute(status: status));
  }

  static void goGameForm(BuildContext context, {
    String? id,
    GameStatus? status,
    String? parentId,
  }) {
    Navigator.push(context, gameFormRoute(id: id, status: status, parentId: parentId));
  }

  static FluentPageRoute gameGridRoute({ required GameStatus status }) {
    return FluentPageRoute(
      builder: (context) {      
        return GameGrid(
          status: status,
        );
      }
    );
  }

  static FluentPageRoute gameFormRoute({
    String? id,
    GameStatus? status,
    String? parentId,
  }) {
    return FluentPageRoute(
      builder: (context) {      
        return GameForm(
          id: id,
          status: status,
          parentId: parentId,
        );
      }
    );
  }
}