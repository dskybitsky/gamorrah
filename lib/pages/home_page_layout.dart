import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
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

class _HomePageLayoutState extends State<HomePageLayout> {
  int _page = 0;

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
            body: GamesNavigator(
              status: GameStatus.backlog,
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.play),
            title: const Text('Playing'),
            body: GamesNavigator(
              status: GameStatus.playing,
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.completed),
            title: const Text('Finished'),
            body: GamesNavigator(
              status: GameStatus.finished,
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.waitlist_confirm),
            title: const Text('Wishlist'),
            body: GamesNavigator(
              status: GameStatus.wishlist,
            ),
          ),   
        ],
        // footerItems: [
        //   PaneItem(
        //     icon: const Icon(FluentIcons.settings),
        //     title: const Text('Settings'),
        //     body: SettingsScreen(),
        //   ),
        // ],
      ),
    );
  }

  void _onPageChanged(int page) {
    setState(() => _page = page);
  }
}