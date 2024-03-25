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

class _GamesPageLayoutStateTabInfo {
  _GamesPageLayoutStateTabInfo({
    required this.games,
    required this.gamesView
  });

  final List<Game> games;
  final GamesView gamesView;
}

class _GamesPageLayoutState extends State<GamesPageLayout> with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;

  late List<_GamesPageLayoutStateTabInfo> _tabInfos;
  
  int _tabIndex = 0;

  GamesFilter? _defaulsGamesFilter;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 0,
      vsync: this,
    );

    _searchController = TextEditingController(text: '');

    _onWidgetGamesViewsChanged();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.gamesViewsState.gamesViews != widget.gamesViewsState.gamesViews) {
      _onWidgetGamesViewsChanged();
    }
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
    _searchController.dispose();
  }

  void _onWidgetGamesViewsChanged() {
    _tabInfos = widget.gamesViewsState.gamesViews
      .where((gamesView) => gamesView.status == widget.status)
      .map((gamesView) => _GamesPageLayoutStateTabInfo(
        games: _getGames(gamesView.filter), 
        gamesView: gamesView)
      )
      .toList();

    _tabInfos
      .sort((tabInfoA, tabInfoB) {
        return tabInfoA.gamesView.index.compareTo(tabInfoB.gamesView.index);
      });

    if (_tabIndex >= _tabInfos.length) {
      _tabIndex = _tabInfos.length - 1;
    }

    if (_tabIndex < 0) {
      _tabIndex = 0;
    }

    _tabController.dispose();

    _tabController = TabController(
      length: _tabInfos.length,
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
    final defaultGames = _tabInfos.isNotEmpty
      ? <Game>[]
      : _getGames(_defaulsGamesFilter);

    return Scaffold(
      appBar: AppBar(
        title: GameStatusText(value: widget.status),
        actions: _buildActions(context),
        bottom: _tabInfos.isNotEmpty
          ? TabBar(
              controller: _tabController,
              tabs: _tabInfos.map((tabInfo) => Tab(
                text: tabInfo.gamesView.name,
              )).toList()
          ) : null,
      ),
      body: _tabInfos.isNotEmpty
        ? TabBarView(
          controller: _tabController,
          children: _tabInfos
            .map((tabInfo) => _buildGamesList(context, tabInfo.games))
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
                count: _tabInfos.isNotEmpty
                  ? _tabInfos[_tabIndex].games.length
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
        child: GamesList(games: _filterGames(games)),
      )
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
              filter: _tabInfos.isNotEmpty
                ? _tabInfos[_tabIndex].gamesView.filter
                : _defaulsGamesFilter,
              onChanged: (value) {
                if (_tabInfos.isNotEmpty) {
                  final newGamesView = _tabInfos[_tabIndex].gamesView.copyWith(
                      filter: Optional(value)
                  );

                  context
                    .read<GamesViewsBloc>()
                    .add(SaveGamesView(gamesView: newGamesView));
                } else {
                  setState(() {
                    _defaulsGamesFilter = value;
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
                context
                  .read<GamesViewsBloc>()
                  .add(SaveGamesView(
                    gamesView: GamesView.create(
                      name: value, 
                      status: widget.status,
                      index: _tabInfos.isNotEmpty 
                        ? _tabInfos.last.gamesView.index + 1
                        : 0,
                      filter: _tabInfos.isNotEmpty 
                        ?_tabInfos.last.gamesView.filter
                        : _defaulsGamesFilter
                    )
                  ));
              },
            ),
            useRootNavigator: false,
          );
        },
      )
    );

    if (_tabInfos.isNotEmpty) {
      widgets.add(HSpacer(size: SpaceSize.xs));
      widgets.add(
        IconButton(
          icon: Icon(Icons.bookmark_remove),
          onPressed: () {
              context
                .read<GamesViewsBloc>()
                .add(DeleteGamesView(id: _tabInfos[_tabIndex].gamesView.id));
          },
        ),
      );
    }

    widgets.add(HSpacer(size: SpaceSize.l));

    return widgets;
  }

  List<Game> _getGames(GamesFilter? filter) {
    final games = widget.gamesState.games
      .where((game) {
        if (game.status != widget.status) {
          return false;
        }

        if (game.parentId != null) {
          return false;
        }

        if (filter == null) {
          return true;
        }

        return filter.matches(game);
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

  List<Game> _filterGames(List<Game> games) {
    final searchText = _searchController.text;

    if (searchText != '') {
      return games
        .where((game) => game.title.contains(RegExp(searchText, caseSensitive: false)))
        .toList();
    }

    return games;
  }
}