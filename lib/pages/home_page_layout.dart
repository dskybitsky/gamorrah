import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/pages/settings_page.dart';
import 'package:gamorrah/state/preferences/preferences_bloc.dart';
import 'package:gamorrah/widgets/game/games_navigator.dart';

class HomePageLayout extends StatefulWidget {
  const HomePageLayout({
    super.key,
    required this.preferencesState
  });

  final PreferencesState preferencesState;

  @override
  State<HomePageLayout> createState() => _HomePageLayoutState();
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

class _HomePageLayoutState extends State<HomePageLayout> {
  int _selectedDestinationIndex = 0;
  late List<_HomePageDestination> _destinations;
  
  @override
  void initState() {
    super.initState();
    
    _destinations = _getDestinations(widget.preferencesState);
  }

  @override
  Widget build(BuildContext context) {
    final selectedDestination = _destinations[_selectedDestinationIndex];

    return Row(
      children: [
        NavigationRail(
          destinations: _destinations.map((destination) => NavigationRailDestination(
            icon: destination.icon, 
            label: Text(destination.title),
          )).toList(), 
          selectedIndex: _selectedDestinationIndex,
          labelType: NavigationRailLabelType.all,
          onDestinationSelected: (index) {
            setState(() => _selectedDestinationIndex = index);
          },
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: selectedDestination.child,
        ),
      ],
    );

    
    // return NavigationRail(
    //   selectedIndex: _page,
    //   onDestinationSelected: _onPageChanged,
    //   destinations: [
    //     _buildGamesDestination(context, state, GameStatus.backlog),
    //     _buildGamesDestination(context, state, GameStatus.playing),
    //     _buildGamesDestination(context, state, GameStatus.finished),
    //     _buildGamesDestination(context, state, GameStatus.wishlist),
    //   ],
    //   // pane: NavigationPane(
    //   //   selected: _page,
    //   //   onChanged: _onPageChanged,
    //   //   displayMode: PaneDisplayMode.auto,
    //   //   items: [
    //   //     _buildGamesPaneItem(context, state, GameStatus.backlog),
    //   //     _buildGamesPaneItem(context, state, GameStatus.playing),
    //   //     _buildGamesPaneItem(context, state, GameStatus.finished),
    //   //     _buildGamesPaneItem(context, state, GameStatus.wishlist),   
    //   //   ],
    //   //   footerItems: [
    //   //     PaneItem(
    //   //       icon: const Icon(FluentIcons.settings),
    //   //       title: Text(t.ui.homePage.settingsLink),
    //   //       body: SettingsPage(),
    //   //     ),
    //   //   ],
    //   // ),
    // );
  }

  

  List<_HomePageDestination> _getDestinations(PreferencesState state) {
    return [
      _getGamesDestination(GameStatus.backlog, state),
      _getGamesDestination(GameStatus.playing, state),
      _getGamesDestination(GameStatus.finished, state),
      _getGamesDestination(GameStatus.wishlist, state),
    ];
  }

  _HomePageDestination _getGamesDestination(GameStatus status, PreferencesState state) {
    final icon = switch (status) {
      GameStatus.backlog => const Icon(Icons.history),
      GameStatus.playing => const Icon(Icons.play_arrow),
      GameStatus.finished => const Icon(Icons.done),
      GameStatus.wishlist => const Icon(Icons.redeem),
    };

    final title = switch (status) {
      GameStatus.backlog => t.types.gameStatus.backlog,
      GameStatus.playing => t.types.gameStatus.playing,
      GameStatus.finished => t.types.gameStatus.finished,
      GameStatus.wishlist => t.types.gameStatus.wishlist,
    };

    return _HomePageDestination(
      icon: icon, 
      title: title,
      child: GamesNavigator(key: Key('games:$status'), status: status),
    );
  }
}