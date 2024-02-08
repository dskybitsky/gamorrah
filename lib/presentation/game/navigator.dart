import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/form.dart';
import 'package:gamorrah/presentation/game/grid.dart';
import 'package:gamorrah/presentation/main_screen.dart';

class GameNavigator extends StatelessWidget {
  const GameNavigator({ 
    Key? key, 
    required this.navigatorKey, 
    required this.status,
    required this.appBarParamsNotifier
  }): super(key: key);

  final GameStatus status;
  final GlobalKey<NavigatorState> navigatorKey;
  final ValueNotifier<MainScreenAppBarParams?> appBarParamsNotifier;

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
              appBarParamsNotifier: appBarParamsNotifier,
            );
          }
        );
      }
    );
  }
}