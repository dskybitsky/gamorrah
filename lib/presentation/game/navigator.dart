import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/form.dart';
import 'package:gamorrah/presentation/game/grid.dart';

class GameNavigator extends StatelessWidget {
  const GameNavigator({ 
    Key? key, 
    required this.navigatorKey, 
    required this.status,
  }): super(key: key);

  final GameStatus status;
  final GlobalKey<NavigatorState> navigatorKey;
  
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings routeSettings) {
        return GameNavigator.gameGridRoute(status);
      }
    );
  }

  static void goGameGrid(BuildContext context, GameStatus status) {
    Navigator.push(context, gameGridRoute(status));
  }

  static void goGameForm(BuildContext context, String? id) {
    Navigator.push(context, gameFormRoute(id));
  }

  static FluentPageRoute gameGridRoute(GameStatus status) {
    return FluentPageRoute(
      builder: (context) {      
        return GameGrid(
          status: status,
        );
      }
    );
  }

  static FluentPageRoute gameFormRoute(String? id) {
    return FluentPageRoute(
      builder: (context) {      
        return GameForm(id: id);
      }
    );
  }
}