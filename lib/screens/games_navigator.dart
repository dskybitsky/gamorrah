import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/screens/games_list.dart';

class GamesNavigator extends StatelessWidget {
  const GamesNavigator({
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
              return GamesListScreen(status: status);
            });
      }
    );
  }
}