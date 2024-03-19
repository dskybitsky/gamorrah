import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/pages/settings_page.dart';
import 'package:gamorrah/state/preferences/preferences_bloc.dart';
import 'package:gamorrah/widgets/game/games_navigator.dart';

class HomePageLayout extends StatefulWidget {
  final int initialPage;

  const HomePageLayout({
    super.key,
    this.initialPage = 0,
  });

  @override
  State<HomePageLayout> createState() => _HomePageLayoutState();
}

class _HomePageDestination {
  _HomePageDestination({
    required this.label,
    required this.icon,
    required this.child
  });

  final String label;
  final Widget icon;
  final Widget child;
}

class _HomePageLayoutState extends State<HomePageLayout> {
  int _selectedDestinationIndex = 0;

  late final List<_HomePageDestination> _destinations;

  @override
  void initState() {
    super.initState();
    _destinations = _getDestinations();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
        if (state.phase.isInitial) {
          return Container();
        }

        if (state.phase.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.phase.isError) {
          return Center(
            child: Text(t.ui.general.errorText),
          );
        }
        
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, PreferencesState state) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Navigation Drawer',
        ),
        backgroundColor: const Color(0xff764abc),
      ),
      drawer: NavigationDrawer(
        selectedIndex: _selectedDestinationIndex,
        
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ..._destinations.map(
            (destination) => NavigationDrawerDestination(
              label: Text(destination.label),
              icon: destination.icon,
            ),
          ),
        ],
        onDestinationSelected: (index) {
         setState(() => _selectedDestinationIndex = index);
        },
      ),
      body: _destinations[_selectedDestinationIndex].child,
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

  List<_HomePageDestination> _getDestinations() {
    return [
      _buildGamesDestination(GameStatus.backlog),
      _buildGamesDestination(GameStatus.playing),
      _buildGamesDestination(GameStatus.finished),
      _buildGamesDestination(GameStatus.wishlist),
    ];
  }

  _HomePageDestination _buildGamesDestination(GameStatus status) {
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

    // final presets = state.preferences.gamesPresets
    //   .where((gamesPreset) => gamesPreset.status == status);

    return _HomePageDestination(
      icon: icon, 
      label: title,
      child: GamesNavigator(key: Key('games:$status'), status: status)
    );

    // if (presets.isEmpty) {
    //   return NavigationRailDestination(icon: icon, label: title, body: GamesNavigator(
    //     status: status,
    //   ));
    // }

    // final items = presets
    //   .map((gamesPreset) => PaneItem(
    //     icon: icon, 
    //     title: Text(gamesPreset.name),
    //     body: GamesNavigator(status: status, preset: gamesPreset)
    //   ))
    //   .toList();

    // return PaneItemExpander(icon: icon, title: title, items: items, 
    //   body: GamesNavigator(status: status),
    //   initiallyExpanded: true,
    // );
  }

  // void _onPageChanged(int page) {
  //   setState(() => _page = page);
  // }
}