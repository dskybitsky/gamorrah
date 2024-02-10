import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/navigator.dart';
import 'package:gamorrah/presentation/main_screen_context.dart';

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
  final ValueNotifier<String?> _appBarTitleNotifier = ValueNotifier(null);
  final ValueNotifier<Widget?> _appBarActionsNotifier = ValueNotifier(null);
  final ValueNotifier<VoidCallback?> _appBarBackTapHandlerNotifier = ValueNotifier(null);
  
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
      appBarBackTapHandlerNotifier: _appBarBackTapHandlerNotifier,
      child: NavigationView(
        appBar: NavigationAppBar(
          automaticallyImplyLeading: false,
          leading: ValueListenableBuilder<VoidCallback?>(
            builder: (BuildContext context, VoidCallback? backTapHandler, Widget? child) {
              if (backTapHandler == null) {
                return Container();
              }

              return PaneItem(
                icon: const Icon(FluentIcons.back, size: 14.0),
                title: Text('Back'),
                body: const SizedBox.shrink(),
              )
                .build(context, false, backTapHandler, displayMode: PaneDisplayMode.compact);
            },
            valueListenable: _appBarBackTapHandlerNotifier,
          ),
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