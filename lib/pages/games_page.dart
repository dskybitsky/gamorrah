import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/widgets/game/games_list.dart';
import 'package:gamorrah/state/game/games_bloc.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({ 
    required this.status,
  });

  final GameStatus status;

  @override
  State<GamesPage> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesPage> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, GamesState>(
      builder: (context, state) {
        if (state.phase.isInitial) {
          return Container();
        }

        if (state.phase.isLoading) {
          return Center(
            child: ProgressRing(),
          );
        }

        if (state.phase.isError) {
          return Center(
            child: Text('Error'),
          );
        }
        
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(BuildContext context, GamesState state) {
    final games = _getGamesList(state);

    return NavigationView(
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: Text(_getTitle()),
        actions: _buildActions(context, state),
      ),
      content: Builder(
        builder: (context) {
          if (state.games.isEmpty) {
            return Center(
              child: Text('Empty'),
            );
          }

          return ScaffoldPage(
            content: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: GamesList(games: games),
            ),
            bottomBar: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: 8, bottom: 8, right: 24),
              child: Text(
                'Games total: ${games.length}',
                style: FluentTheme.of(context).typography.caption,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActions(BuildContext context, GamesState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 196,
              child: TextBox(
                placeholder: "Filter",
                onChanged: (value) {
                  setState(() {
                    _filter = value;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                overflowBehavior: CommandBarOverflowBehavior.noWrap,
                primaryItems: [
                  CommandBarButton(
                    icon: const Icon(FluentIcons.add),
                    label: const Text('Add New Game'),
                    onPressed: () {
                      // GameNavigator.goGameScreen(context, status: state.status);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(width: 24),
      ]
    );
  }

  List<Game> _getGamesList(GamesState state) {
    final games = state.games
      .where((game) {
        return game.status == widget.status
          && game.parentId == null
          && (
            _filter == '' 
            || game.title.contains(RegExp(_filter, caseSensitive: false))
          );
      })
      .toList();

    games.sort((Game gameA, Game gameB) {
      final franchisedTitleA = gameA.franchise ?? gameA.title;
      final franchisedTitleB = gameB.franchise ?? gameB.title;
              
      if (franchisedTitleA == franchisedTitleB) {
        final franchisedIndexA = gameA.index ?? gameA.year ?? 0;
        final franchisedIndexB = gameB.index ?? gameB.year ?? 0;
                  
        return franchisedIndexA.compareTo(franchisedIndexB);
      }
              
      return franchisedTitleA.compareTo(franchisedTitleB);
    });

    return games;
  }

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