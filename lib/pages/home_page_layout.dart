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
    this.destinations = const [],
  });

  final String title;
  final Widget icon;
  final Widget child;
  final List<_HomePageDestination> destinations;
}

class _HomePageLayoutState extends State<HomePageLayout> with TickerProviderStateMixin {
  int _selectedDestinationIndex = 0;
  late List<_HomePageDestination> _destinations;
  late TabController _subDestinationsTabController;

  @override
  void initState() {
    super.initState();
    
    _destinations = _getDestinations(widget.preferencesState);

    _subDestinationsTabController = TabController(
      length: _destinations[_selectedDestinationIndex].destinations.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedDestination = _destinations[_selectedDestinationIndex];

    if (selectedDestination.destinations.length != _subDestinationsTabController.length) {
      _subDestinationsTabController.dispose();

      _subDestinationsTabController = TabController(
        length: _destinations[_selectedDestinationIndex].destinations.length,
        initialIndex: 0,
        vsync: this,
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(selectedDestination.title),
        bottom: selectedDestination.destinations.isNotEmpty 
          ? TabBar(
              controller: _subDestinationsTabController,
              tabs: selectedDestination.destinations.map((subDestination) => Tab(
                text: subDestination.title,
              )).toList()
          ) : null,
      ),
        
      body: Row(
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
            child: _subDestinationsTabController.length > 0 
              ? TabBarView(
                controller: _subDestinationsTabController,
                children: _destinations[_selectedDestinationIndex].destinations
                  .map((subDestination) => subDestination.child)
                  .toList(),
              )
              : _destinations[_selectedDestinationIndex].child
          )
        ],
      ),
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

    final presets = state.preferences.gamesPresets
      .where((gamesPreset) => gamesPreset.status == status);

    return _HomePageDestination(
      icon: icon, 
      title: title,
      child: GamesNavigator(key: Key('games:$status'), status: status),
      destinations: presets.map((preset) => _HomePageDestination(
        icon: icon,
        title: preset.name,
        child: GamesNavigator(key: Key('games:$status:${preset.name}'), status: status, preset: preset,)
      )).toList()
    );
  }
}