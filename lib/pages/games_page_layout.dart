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
import 'package:gamorrah/widgets/game/game_status_text.dart';
import 'package:gamorrah/widgets/game/games_list.dart';
import 'package:gamorrah/widgets/ui/hspacer.dart';
import 'package:gamorrah/widgets/ui/space_size.dart';

class GamesPageLayout extends StatefulWidget {
  const GamesPageLayout({ 
    super.key,
    required this.gamesState,
    required this.gamesViewsState,
    required this.status,
  });

  final GamesState gamesState;
  final GamesViewsState gamesViewsState;
  final GameStatus status;

  @override
  State<GamesPageLayout> createState() => _GamesPageLayoutState();
}

class _GamesPageLayoutState extends State<GamesPageLayout> with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;

  late List<GamesView> _gamesViews;
  int _gamesViewIndex = 0;

  GamesFilter? _defaultFilter;

  @override
  void initState() {
    super.initState();

    _gamesViews = widget.gamesViewsState.gamesViews
      .where((gamesView) => gamesView.status == widget.status)
      .toList();

    _gamesViews
      .sort((gamesViewA, gamesViewB) {
        return gamesViewA.index.compareTo(gamesViewB.index);
      });

    if (_gamesViewIndex >= _gamesViews.length) {
      _gamesViewIndex = _gamesViews.length - 1;
    }

    if (_gamesViewIndex < 0) {
      _gamesViewIndex = 0;
    }

    _initTabController(false);

    _searchController = TextEditingController(text: '');
  }

  void _initTabController(bool needsDispose) {
    if (needsDispose) {
      _tabController.dispose();
    }

    _tabController = TabController(
      length: _gamesViews.length,
      initialIndex: _gamesViewIndex,
      vsync: this,
    );

    _tabController.addListener(() {
        if (_gamesViewIndex != _tabController.index) {
          setState(() {
            _gamesViewIndex = _tabController.index;
          });
        }
      });
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController.length != _gamesViews.length) {
      _initTabController(true);
    }

    final games = _getGames();

    final gamesViewsGames = _gamesViews
      .map((gamesView) => _filterGames(games, gamesView.filter))
      .toList();

    final defaultGames = _filterGames(games, _defaultFilter);

    return Scaffold(
      appBar: AppBar(
        title: GameStatusText(value: widget.status),
        actions: _buildActions(context),
        bottom: _gamesViews.isNotEmpty
          ? TabBar(
              controller: _tabController,
              tabs: _gamesViews.map((gamesView) => Tab(
                text: gamesView.name,
              )).toList()
          ) : null,
      ),
      body: _gamesViews.isNotEmpty
        ? TabBarView(
          controller: _tabController,
          children: gamesViewsGames
            .map((games) => _buildGamesList(context, games))
            .toList()
        )
        : _buildGamesList(context, defaultGames),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0, top: 8.0, bottom: 8.0, right: 16.0),
            child: Text(
              t.ui.gamesPage.gamesTotalText(
                count: _gamesViews.isNotEmpty 
                  ? gamesViewsGames[_gamesViewIndex].length
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

  List<Widget> _buildActions(BuildContext context) {
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
              filter: _gamesViews.isNotEmpty
                ? _gamesViews[_gamesViewIndex].filter
                : _defaultFilter,
              onChanged: (value) {
                if (_gamesViews.isNotEmpty) {
                  final newGamesView = _gamesViews[_gamesViewIndex].copyWith(
                      filter: Optional(value)
                  );

                  setState(() {
                    _gamesViews[_gamesViewIndex] = newGamesView;
                  });

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
  
    widgets.add(HSpacer(size: SpaceSize.m));
    widgets.add(
      IconButton(
        icon: Icon(Icons.bookmark_add),
        onPressed:() {
          showDialog(
            context: context,
            builder: (context) => GamesPageSaveViewDialog(
              onChanged: (value) {
                final newGamesView = GamesView.create(
                  name: value, 
                  status: widget.status,
                  index: _gamesViews.isNotEmpty 
                    ? _gamesViews.last.index + 1
                    : 0,
                  filter: _gamesViews.isNotEmpty 
                    ? _gamesViews.last.filter
                    : _defaultFilter
                );

                context
                  .read<GamesViewsBloc>()
                  .add(SaveGamesView(gamesView: newGamesView));

                setState(() {
                  _gamesViews.add(newGamesView);
                  _gamesViewIndex = _gamesViews.length - 1;
                });
              },
            ),
            useRootNavigator: false,
          );
        },
      )
    );

    if (_gamesViews.isNotEmpty) {
      widgets.add(HSpacer(size: SpaceSize.xs));
      widgets.add(
        IconButton(
          icon: Icon(Icons.bookmark_remove),
          onPressed: () {
            final id = _gamesViews[_gamesViewIndex].id;

            context
              .read<GamesViewsBloc>()
              .add(DeleteGamesView(id: id));

            setState(() {
              _gamesViews.removeWhere((gamesView) => gamesView.id == id);
              
              if (_gamesViewIndex >= _gamesViews.length) {
                _gamesViewIndex = _gamesViews.length > 0 
                  ? _gamesViews.length - 1
                  : 0;
              }
            });
          },
        ),
      );
    }

    widgets.add(HSpacer(size: SpaceSize.l));

    return widgets;
  }

  List<Game> _getGames() {
    final games = widget.gamesState.games
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