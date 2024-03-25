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
  late GamesFilter? _filter;
  late List<GamesView> _gamesViews;
  int _gamesViewIndex = 0;
  
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
    _gamesViews = widget.gamesViewsState.gamesViews
      .where((gamesView) => gamesView.status == widget.status)
      .toList();

    _gamesViews
      .sort((GamesView gamesViewA, GamesView gamesViewB) {
        return gamesViewA.index.compareTo(gamesViewB.index);
      });

    if (_gamesViewIndex >= _gamesViews.length) {
      _gamesViewIndex = _gamesViews.length - 1;
    }

    if (_gamesViewIndex < 0) {
      _gamesViewIndex = 0;
    }

    _tabController.dispose();

    _tabController = TabController(
      length: _gamesViews.length,
      initialIndex: _gamesViewIndex,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _gamesViewIndex = _tabController.index;
          _filter = _gamesViews[_gamesViewIndex].filter;
        });
      }
    });

    _filter = _gamesViews.isNotEmpty
        ? _gamesViews[_gamesViewIndex].filter
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final games = _getGames(_filter);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        actions: _buildActions(context),
        bottom: _gamesViews.isNotEmpty
          ? TabBar(
              controller: _tabController,
              // isScrollable: true,
              tabs: _gamesViews.map((gamesView) => Tab(
                text: gamesView.name,
              )).toList()
          ) : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: GamesList(games: games),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 0, top: 8.0, bottom: 8.0, right: 16.0),
            child: Text(t.ui.gamesPage.gamesTotalText(count: games.length)),
          )
        ],
      ),
    );
  }

  List<Game> _getGames(GamesFilter? filter) {
    final searchText = _searchController.text;

    final games = widget.gamesState.games
      .where((game) {
        if (game.status != widget.status) {
          return false;
        }

        if (game.parentId != null) {
          return false;
        }

        return (
          (searchText == '' || game.title.contains(RegExp(searchText, caseSensitive: false)))
          && (filter == null || filter.matches(game))
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
              filter: _filter,
              onChanged: (value) {
                if (_gamesViews.isNotEmpty) {
                  final newGamesView = _gamesViews[_gamesViewIndex].copyWith(
                      filter: Optional(value)
                  );

                  context
                    .read<GamesViewsBloc>()
                    .add(SaveGamesView(gamesView: newGamesView));
                } else {
                  setState(() {
                    _filter = value;
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
                      index: _gamesViews.isNotEmpty 
                        ? _gamesViews.last.index + 1
                        : 0,
                      filter: _filter
                    )
                  ));
              },
            ),
            useRootNavigator: false,
          );
        },
      )
    );

    if (_gamesViews.isNotEmpty) {
      final currentGamesView = _gamesViews[_gamesViewIndex];

      widgets.add(HSpacer(size: SpaceSize.xs));
      widgets.add(
        IconButton(
          icon: Icon(Icons.bookmark_remove),
          onPressed: () {
              context
                .read<GamesViewsBloc>()
                .add(DeleteGamesView(id: currentGamesView.id));
          },
        ),
      );
    }

    widgets.add(HSpacer(size: SpaceSize.l));

    return widgets;
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