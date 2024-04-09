import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/games_view/games_view.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/pages/games_page_filter_dialog.dart';
import 'package:gamorrah/pages/games_page_save_view_dialog.dart';
import 'package:gamorrah/state/game/games_bloc.dart';
import 'package:gamorrah/state/games_view/games_views_bloc.dart';
import 'package:gamorrah/state/state_phase.dart';
import 'package:gamorrah/widgets/game/games_list.dart';
import 'package:gamorrah/widgets/game/games_navigator.dart';
import 'package:gamorrah/widgets/ui/spacer.dart';

class GamesPage extends StatefulWidget {
  GamesPage({
    super.key,
    required this.status,
  });

  final GameStatus status;

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;

  int _tabIndex = 0;

  GamesFilter? _defaultFilter;

  @override
  void initState() {
    super.initState();

    _initTabController([], false);

    _searchController = TextEditingController(text: '');
  }

  void _initTabController(List<GamesView> gamesViews, bool needsDispose) {
    if (needsDispose) {
      _tabController.dispose();
    }

    _tabIndex = max(min(_tabIndex, gamesViews.length - 1), 0);

    _tabController = TabController(
      length: gamesViews.length,
      initialIndex: _tabIndex,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabIndex != _tabController.index) {
        setState(() {
          _tabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, GamesState>(
      builder: (context, gamesState) {
        if (gamesState.phase.isInitial) {
          return Container();
        }

        if (gamesState.phase.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (gamesState.phase.isError) {
          return Center(
            child: Text(t.ui.general.errorText),
          );
        }
        
        return BlocBuilder<GamesViewsBloc, GamesViewsState>(
          builder: (context, gamesViewsState) {
            if (gamesViewsState.phase.isInitial) {
              return Container();
            }

            if (gamesViewsState.phase.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (gamesViewsState.phase.isError) {
              return Center(
                child: Text(t.ui.general.errorText),
              );
            }
            
            return _buildContent(context, gamesState, gamesViewsState);
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, GamesState gamesState, GamesViewsState gamesViewsState) {
    final gamesViews = _getGamesViews(gamesViewsState);

    if (_tabController.length != gamesViews.length) {
      _initTabController(gamesViews, true);
    }

    final games = _getGames(gamesState);

    final gamesViewsGames = gamesViews
      .map((gamesView) => _filterGames(games, gamesView.filter))
      .toList();

    final defaultGames = _filterGames(games, _defaultFilter);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.types.gameStatus.values[widget.status.name]!),
        actions: _buildActions(context, gamesViews, gamesState.tags),
        bottom: gamesViews.isNotEmpty
          ? TabBar(
              controller: _tabController,
              tabs: gamesViews.map((gamesView) => Tab(
                text: gamesView.name,
              )).toList()
          ) : null,
      ),
      body: gamesViews.isNotEmpty
        ? TabBarView(
          controller: _tabController,
          children: gamesViewsGames
            .map((games) => _buildGamesList(context, games))
            .toList()
        )
        : _buildGamesList(context, defaultGames),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0, top: 8.0, bottom: 8.0, right: 16.0),
            child: Text(
              t.ui.gamesPage.gamesTotalText(
                count: gamesViews.isNotEmpty 
                  ? gamesViewsGames[_tabIndex].length
                  : defaultGames.length
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGamesList(BuildContext context, List<Game> games) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: GamesList(games: _searchGames(games, _searchController.text)),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context, List<GamesView> gamesViews, Set<String> tags) {
    final List<Widget> widgets = [];

    widgets.add(
      SizedBox(
        width: 150,
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: t.ui.gamesPage.searchPlaceholder,
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              
            });
          },
        ),
      )
    );

    widgets.add(
      IconButton(
        icon: Icon(Icons.filter_alt),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => GamesPageFilterDialog(
              filter: gamesViews.isNotEmpty
                ? gamesViews[_tabIndex].filter
                : _defaultFilter,
              tags: tags,
              onChanged: (value) {
                if (gamesViews.isNotEmpty) {
                  final newGamesView = gamesViews[_tabIndex].copyWith(
                      filter: Optional(value)
                  );

                  context
                    .read<GamesViewsBloc>()
                    .add(SaveGamesView(gamesView: newGamesView));
                } else {
                  setState(() {
                    _defaultFilter = value;
                  });
                }
              },
            ),
            useRootNavigator: false,
          ); 
        }, 
      )
    );
  
    widgets.add(HSpacer(size: SpaceSize.l));
    widgets.add(
      IconButton(
        icon: Icon(Icons.create_new_folder_outlined),
        onPressed:() {
          final newGamesView = GamesView.create(
            name: t.ui.gamesPage.defaultGamesViewName, 
            status: widget.status,
            index: gamesViews.isNotEmpty 
              ? gamesViews.last.index + 1
              : 0,
            filter: gamesViews.isNotEmpty 
              ? gamesViews.last.filter
              : _defaultFilter
          );

          showDialog(
            context: context,
            builder: (context) => GamesPageSaveViewDialog(
              value: newGamesView,
              onChanged: (value) {
                 context
                  .read<GamesViewsBloc>()
                  .add(SaveGamesView(gamesView: value));
              },
            ),
            useRootNavigator: false,
          );
        },
      )
    );

    if (gamesViews.isNotEmpty) {
      widgets.add(HSpacer(size: SpaceSize.xs));
      widgets.add(
        IconButton(
          icon: Icon(Icons.snippet_folder_outlined),
          onPressed:() {
            showDialog(
              context: context,
              builder: (context) => GamesPageSaveViewDialog(
                value: gamesViews[_tabIndex],
                onChanged: (value) {
                  context
                    .read<GamesViewsBloc>()
                    .add(SaveGamesView(gamesView: value));
                },
              ),
              useRootNavigator: false,
            );
          },
        )
      );
      
      widgets.add(HSpacer(size: SpaceSize.xs));
      widgets.add(
        IconButton(
          icon: Icon(Icons.folder_delete_outlined),
          onPressed: () {
            final id = gamesViews[_tabIndex].id;

            context
              .read<GamesViewsBloc>()
              .add(DeleteGamesView(id: id));
          },
        ),
      );
    }

    widgets.add(HSpacer(size: SpaceSize.l));

    return widgets;
  }

  List<GamesView> _getGamesViews(GamesViewsState state) {
    final gamesViews = state.gamesViews
      .where((gamesView) => gamesView.status == widget.status)
      .toList();

    gamesViews
      .sort((gamesViewA, gamesViewB) {
        return gamesViewA.index.compareTo(gamesViewB.index);
      });

    return gamesViews;
  }

  List<Game> _getGames(GamesState state) {
    final games = state.games
      .where((game) {
        if (game.status != widget.status) {
          return false;
        }

        if (game.parentId != null) {
          return false;
        }

        return true;
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

  List<Game> _filterGames(List<Game> games, GamesFilter? filter) {
    if (filter != null) {
      return games
        .where((game) => filter.matches(game))
        .toList();
    }

    return games;
  }

  List<Game> _searchGames(List<Game> games, String searchText) {
    if (searchText != '') {
      return games
        .where((game) => game.title.contains(RegExp(searchText, caseSensitive: false)))
        .toList();
    }
    
    return games;
  }
}