import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/navigator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreen> {
  static const GameBacklogIndex = 0;
  static const GamePlayingIndex = 1;
  static const GameFinishedIndex = 2;
  static const GameWishlistIndex = 3;

  int _selectedIndex = 0;
  
  @override
  void initState() {
    super.initState();
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case _MainScreenState.GameBacklogIndex:
        return 'Backlog';
      case _MainScreenState.GamePlayingIndex:
        return 'Playing';
      case _MainScreenState.GameFinishedIndex:
        return 'Finished';
      case _MainScreenState.GameWishlistIndex:
        return 'Wishlist';
    }

    return 'Home';
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: Text(_getTitle()),
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
            body: GameNavigator(
              navigatorKey: GlobalKey<NavigatorState>(),
              status: GameStatus.backlog,
            ),            
          ),
          PaneItem(
            icon: const Icon(FluentIcons.play),
            title: const Text('Playing'),
            body: GameNavigator(
              navigatorKey: GlobalKey<NavigatorState>(),
              status: GameStatus.playing,
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.completed),
            title: const Text('Finished'),
            body: GameNavigator(
              navigatorKey: GlobalKey<NavigatorState>(),
              status: GameStatus.finished,
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.waitlist_confirm),
            title: const Text('Wishlist'),
            body: GameNavigator(
              navigatorKey: GlobalKey<NavigatorState>(),
              status: GameStatus.wishlist,
            ),
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