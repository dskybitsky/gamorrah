import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/navigator.dart';

class MainScreenAppBarParams {
  const MainScreenAppBarParams({
    required this.title,
    this.actions
  });

  final String title;
  final Widget? actions;
}

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
  final ValueNotifier<MainScreenAppBarParams?> _appBarParamsNotifier = ValueNotifier(null);

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
          title: ValueListenableBuilder<MainScreenAppBarParams?>(
            builder: (BuildContext context, MainScreenAppBarParams? appBarParams, Widget? child) {
              return Text(appBarParams?.title ?? 'Main');
            },
            valueListenable: _appBarParamsNotifier,
          ),
          actions: ValueListenableBuilder<MainScreenAppBarParams?>(
            builder: (BuildContext context, MainScreenAppBarParams? appBarParams, Widget? child) {
              return appBarParams?.actions ?? Container();
            },
            valueListenable: _appBarParamsNotifier,
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
                appBarParamsNotifier: _appBarParamsNotifier,
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.play),
              title: const Text('Playing'),
              body: GameNavigator(
                navigatorKey: GlobalKey(),
                status: GameStatus.playing,
                appBarParamsNotifier: _appBarParamsNotifier,
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.completed),
              title: const Text('Finished'),
              body: GameNavigator(
                navigatorKey: GlobalKey(),
                status: GameStatus.finished,
                appBarParamsNotifier: _appBarParamsNotifier,
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.waitlist_confirm),
              title: const Text('Wishlist'),
              body: GameNavigator(
                navigatorKey: GlobalKey(),
                status: GameStatus.wishlist,
                appBarParamsNotifier: _appBarParamsNotifier,
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