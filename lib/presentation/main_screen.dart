import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/navigator.dart';

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
  final ValueNotifier<String?> _appBarTitleNotifier = ValueNotifier<String?>(null);

  int _page = 0;
  
  @override
  void initState() {
    super.initState();

    _page = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
        // appBar: NavigationAppBar(
        //   title: _appBarParams?.title,
        //   // actions: _appBarParams.actions,
        // ),
        appBar: NavigationAppBar(
          title: ValueListenableBuilder<String?>(
            builder: (BuildContext context, String? value, Widget? child) {
              return Text(value ?? 'Main');
            },
            valueListenable: _appBarTitleNotifier,
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
                titleNotifier: _appBarTitleNotifier,
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.play),
              title: const Text('Playing'),
              body: GameNavigator(
                navigatorKey: GlobalKey(),
                status: GameStatus.playing,
                titleNotifier: _appBarTitleNotifier,
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.completed),
              title: const Text('Finished'),
              body: GameNavigator(
                navigatorKey: GlobalKey(),
                status: GameStatus.finished,
                titleNotifier: _appBarTitleNotifier,
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.waitlist_confirm),
              title: const Text('Wishlist'),
              body: GameNavigator(
                navigatorKey: GlobalKey(),
                status: GameStatus.wishlist,
                titleNotifier: _appBarTitleNotifier,
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

  void _onPageChanged(int page) {
    setState(() => _page = page);
  }
}