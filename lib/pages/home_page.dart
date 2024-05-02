import 'package:flutter/material.dart';
import 'package:my_game_db/i18n/strings.g.dart';
import 'package:my_game_db/models/game/game.dart';
import 'package:my_game_db/pages/settings_page.dart';
import 'package:my_game_db/widgets/game/game_status_icon.dart';
import 'package:my_game_db/widgets/game/games_navigator.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageDestination {
  _HomePageDestination({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final Widget icon;
  final Widget child;
}

class _HomePageState extends State<HomePage> {
  int _destinationIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final destinations = _getDestinations();
    final selectedDestination = destinations[_destinationIndex];

    return Row(
      children: [
        NavigationRail(
          destinations: destinations
            .map((destination) => NavigationRailDestination(
              icon: destination.icon, 
              label: Text(destination.title),
            )).toList(), 
          selectedIndex: _destinationIndex,
          labelType: NavigationRailLabelType.all,
          onDestinationSelected: (index) {
            setState(() => _destinationIndex = index);
          },
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: selectedDestination.child,
        ),
      ],
    );
  }
  
  List<_HomePageDestination> _getDestinations() {
    return [
      _getGamesDestination(GameStatus.backlog),
      _getGamesDestination(GameStatus.playing),
      _getGamesDestination(GameStatus.finished),
      _getGamesDestination(GameStatus.wishlist),
      _HomePageDestination(
        title: t.ui.settingsPage.settingsTitle, 
        icon: Icon(Icons.settings),
        child: SettingsPage()
      ),
    ];
  }

  _HomePageDestination _getGamesDestination(GameStatus status) {
    return _HomePageDestination(
      icon: GameStatusIcon(value: status), 
      title: t.types.gameStatus.values[status.name]!,
      child: GamesNavigator(key: Key('games:$status'), status: status),
    );
  }
}