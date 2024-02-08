import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/navigator.dart';
import 'package:gamorrah/presentation/main_screen_context.dart';

class MainScreen extends StatefulWidget {
  final int initialPage;

  const MainScreen({
    Key? key,
    this.initialPage = 0,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final ValueNotifier<String?> _appBarTitleNotifier = ValueNotifier(null);
  final ValueNotifier<Widget?> _appBarActionsNotifier = ValueNotifier(null);
  
  int _page = 0;
  
  @override
  void initState() {
    super.initState();

    _page = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenContext(
      appBarTitleNotifier: _appBarTitleNotifier,
      appBarActionsNotifier: _appBarActionsNotifier, 
      child: NavigationView(
        appBar: NavigationAppBar(
          title: ValueListenableBuilder<String?>(
            builder: (BuildContext context, String? value, Widget? child) {
              return Text(value ?? 'Main');
            },
            valueListenable: _appBarTitleNotifier,
          ),
          actions: ValueListenableBuilder<Widget?>(
            builder: (BuildContext context, Widget? value, Widget? child) {
              return value ?? Container();
            },
            valueListenable: _appBarActionsNotifier,
          ),
        ),
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
              body: Container(),
            ),
          ],
        ), 
      )
    );
  }

  void _onPageChanged(int page) {
    setState(() => _page = page);
  }
}