import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/screens/games_navigator.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String _appTitle = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: Text(_appTitle),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: (index) => setState(() => _selectedIndex = index),
        displayMode: PaneDisplayMode.compact,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.history),
            title: const Text('Backlog'),
            body: GamesNavigator(
              navigatorKey: GlobalKey<NavigatorState>(),
              status: GameStatus.backlog,
            ),
            onTap: () => setState(() {
              _appTitle = 'Backlog';
            }),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.play),
            title: const Text('Playing'),
            body: GamesNavigator(
              navigatorKey: GlobalKey<NavigatorState>(),
              status: GameStatus.playing,
            ),
            onTap: () => setState(() {
              _appTitle = 'Playing';
            }),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.completed),
            title: const Text('Finished'),
            body: GamesNavigator(
              navigatorKey: GlobalKey<NavigatorState>(),
              status: GameStatus.finished,
            ),
            onTap: () => setState(() {
              _appTitle = 'Finished';
            }),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.waitlist_confirm),
            title: const Text('Wishlist'),
            body: GamesNavigator(
              navigatorKey: GlobalKey<NavigatorState>(),
              status: GameStatus.wishlist,
            ),
            onTap: () => setState(() {
              _appTitle = 'Wishlist';
            }),
          ),   
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: Container(),
          ),
        ],
      ), 
    );
  }
}