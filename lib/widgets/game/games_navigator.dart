import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/preferences/preferences.dart';
import 'package:gamorrah/pages/games_page.dart';
import 'package:gamorrah/pages/game_page.dart';

class GamesNavigator extends StatelessWidget {
  const GamesNavigator({ 
    super.key, 
    required this.status,
    this.preset
  });

  final GameStatus status;
  final GamesPreset? preset;
  
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings routeSettings) {
        return GamesNavigator.gamesRoute(status: status, preset: preset);
      }
    );
  }

  static void goGames(BuildContext context, { required GameStatus status, GamesPreset? preset }) {
    Navigator.push(context, gamesRoute(status: status, preset: preset));
  }

  static void goGame(BuildContext context, { required String id }) {
    Navigator.push(context, gameRoute(id: id));
  }

  static FluentPageRoute gamesRoute({ required GameStatus status, GamesPreset? preset }) {
    return FluentPageRoute(
      builder: (context) {      
        return GamesPage(
          status: status,
          preset: preset
        );
      }
    );
  }

  static FluentPageRoute gameRoute({ required String id }) {
    return FluentPageRoute(
      builder: (context) {      
        return GamePage(id: id);
      }
    );
  }
}