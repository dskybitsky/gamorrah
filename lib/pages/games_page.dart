import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/widgets/game/games_list.dart';
import 'package:gamorrah/state/game/games_bloc.dart';
import 'package:gamorrah/widgets/game/games_navigator.dart';
import 'package:gamorrah/widgets/ui/hspacer.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({ 
    required this.status,
  });

  final GameStatus status;

  @override
  State<GamesPage> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesPage> {
  late TextEditingController _filterController;

  @override
  void initState() {
    super.initState();

     _filterController = TextEditingController(text: '');
  }

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
            child: Text(t.ui.general.errorText),
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
              child: Text(t.ui.general.emptyText),
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
                t.ui.gamesPage.gamesTotalText(count: games.length),
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
                controller: _filterController,
                placeholder: t.ui.gamesPage.searchPlaceholder,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        HSpacer(size: HSpacerSize.s),
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
                    label: Text(t.ui.gamesPage.addGameButton),
                    onPressed: () {
                      final game = Game.create(
                        title: t.ui.gamesPage.defaultGameTitle, 
                        thumbUrl: null,
                        status: widget.status,
                      );

                      context.read<GamesBloc>().add(SaveGame(game: game));

                      GamesNavigator.goGame(context, id: game.id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        HSpacer(size: HSpacerSize.l),
      ]
    );
  }

  List<Game> _getGamesList(GamesState state) {
    final filter = _filterController.text;

    final games = state.games
      .where((game) {
        return game.status == widget.status
          && game.parentId == null
          && (
            filter == '' 
            || game.title.contains(RegExp(filter, caseSensitive: false))
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
        return t.types.gameStatus.backlog;
      case GameStatus.playing:
        return t.types.gameStatus.playing;
      case GameStatus.finished:
        return t.types.gameStatus.finished;
      case GameStatus.wishlist:
        return t.types.gameStatus.wishlist;
    }
  }
}