import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/grid.dart';

class GameNavigator extends StatelessWidget {
  const GameNavigator({
    Key? key, 
    required this.navigatorKey, 
    required this.status,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final GameStatus status;
  
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,

      onGenerateRoute: (RouteSettings routeSettings) {
        return FluentPageRoute(
            settings: routeSettings,
            builder: (context) {      
              return GameGrid(
                status: status,
              );
            });
      }
    );
  }
}