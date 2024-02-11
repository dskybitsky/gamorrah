import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/navigator.dart';
import 'package:gamorrah/presentation/settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialPage;

  const MainScreen({
    super.key,
    this.initialPage = 0,
  });

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _page = 0;
  
  @override
  void initState() {
    super.initState();

    _page = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: _page,
        onChanged: _onPageChanged,
        displayMode: PaneDisplayMode.compact,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.history),
            title: const Text('Backlog'),
            body: GameNavigator(
              navigatorKey: GlobalKey(),
              status: GameStatus.backlog,
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.play),
            title: const Text('Playing'),
            body: GameNavigator(
              navigatorKey: GlobalKey(),
              status: GameStatus.playing,
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.completed),
            title: const Text('Finished'),
            body: GameNavigator(
              navigatorKey: GlobalKey(),
              status: GameStatus.finished,
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.waitlist_confirm),
            title: const Text('Wishlist'),
            body: GameNavigator(
              navigatorKey: GlobalKey(),
              status: GameStatus.wishlist,
            ),
          ),   
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: SettingsScreen(),
          ),
        ],
      ),
    );
  }

  void _onPageChanged(int page) {
    setState(() => _page = page);
  }
}