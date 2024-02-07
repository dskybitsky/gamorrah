import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/presentation/game/form.dart';
import 'package:gamorrah/presentation/game/grid.dart';

class GameNavigator extends StatefulWidget {
  const GameNavigator({ 
    Key? key, 
    required this.navigatorKey, 
    required this.status,
    required this.titleNotifier
  }): super(key: key);

  final GameStatus status;
  final GlobalKey<NavigatorState> navigatorKey;
  final ValueNotifier<String?> titleNotifier;

  @override
  State<GameNavigator> createState() => _GameNavigatorState();
}

class _GameNavigatorState extends State<GameNavigator> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.titleNotifier.value = _getTitle();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,

      onGenerateRoute: (RouteSettings routeSettings) {
        return FluentPageRoute(
          settings: routeSettings,
          builder: (context) {      
            return GameGrid(
              status: widget.status,
            );
          }
        );
      }
    );
  }

  // NavigationAppBar buildAppBar(BuildContext context) {
  //   return NavigationAppBar(
  //     title: Text(_getTitle()),
  //     actions: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(right: 48),
  //           child: 
  //             CommandBar(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               primaryItems: [
  //                 CommandBarButton(
  //                   icon: const Icon(FluentIcons.add),
  //                   label: const Text('Create'),
  //                   onPressed: () {
  //                     Navigator.push(context, FluentPageRoute(builder: (_) => GameForm()));
  //                   },
  //                 ),
  //                 // CommandBarButton(
  //                 //   icon: const Icon(FluentIcons.delete),
  //                 //   label: const Text('Delete'),
  //                 //   onPressed: () {},
  //                 // ),
  //               ],
  //             )
  //         )
  //       ]
  //     ),
  //     automaticallyImplyLeading: false,
  //   );
  // }

  String _getTitle() {
    switch (widget.status) {
      case GameStatus.backlog:
        return 'Backlog';
      case GameStatus.playing:
        return 'Playing';
      case GameStatus.finished:
        return 'Finished';
      case GameStatus.wishlist:
        return 'Wishlist';
    }
  }
}