import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/preferences/preferences.dart';
import 'package:gamorrah/pages/games_page_filter_dialog.dart';
import 'package:gamorrah/state/game/games_bloc.dart';
import 'package:gamorrah/widgets/game/games_list.dart';
import 'package:gamorrah/widgets/ui/hspacer.dart';
import 'package:gamorrah/widgets/ui/space_size.dart';

class GamesPageLayout extends StatefulWidget {
  const GamesPageLayout({ 
    super.key,
    required this.gamesState,
    required this.status,
    this.presets = const [],
  });

  final GamesState gamesState;
  final GameStatus status;
  final List<GamesPreset> presets;

  @override
  State<GamesPageLayout> createState() => _GamesPageLayoutState();
}

class _GamesPageLayoutState extends State<GamesPageLayout> with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;
  late GamesFilter? _filter;
  late int _presetIndex;
  
  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: widget.presets.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _presetIndex = _tabController.index;
          _filter = widget.presets[_presetIndex].filter;
        });
      }
    });

    _presetIndex = widget.presets.isNotEmpty ? 0 : -1;

    _filter = _presetIndex >= 0 
        ? widget.presets[_presetIndex].filter
        : null;

    _searchController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    final games = _getGamesList(_filter);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        actions: [
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
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => GamesPageFilterDialog(
                  filter: _filter,
                  onChanged: (value) {
                    setState(() {
                      _filter = value;
                    });
                  },
                ),
                useRootNavigator: false,
              );  
            }, 
            icon: Icon(Icons.filter_alt)
          ),
          HSpacer(size: SpaceSize.xs),
          IconButton(
            onPressed: null, 
            icon: Icon(Icons.save_as)
          ),
          HSpacer(size: SpaceSize.xs),
          IconButton(
            onPressed: null, 
            icon: Icon(Icons.delete)
          ),
          HSpacer(size: SpaceSize.l)
        ],
        bottom: widget.presets.isNotEmpty
          ? TabBar(
              controller: _tabController,
              tabs: widget.presets.map((preset) => Tab(
                text: preset.name,
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

  List<Game> _getGamesList(GamesFilter? filter) {
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

  // Widget _buildActions(BuildContext context, GamesState state) {
    
  //   final filterWidget = Tooltip(
  //     message: t.ui.gamesPage.filterButton,
  //     child: IconButton(
  //       icon: _filter.isEmpty
  //         ? Icon(Icons.filter)
  //         : Icon(Icons.filter, color: Colors.blue),
  //       onPressed: () {
  //         showDialog(
  //           context: context,
  //           builder: (context) => GamesFilterDialog(
  //             filter: _filter,
  //             onChanged: (value) {
  //               setState(() {
  //                 _filter = value;
  //               });
  //             },
  //           ),
  //           useRootNavigator: false,
  //         );
  //       },
  //     )
  //   );

  //   final savePresetWidget = Tooltip(
  //     message: t.ui.gamesPage.savePresetButton,
  //     child: IconButton(
  //       icon: Icon(Icons.save),
  //       onPressed: _filter.isEmpty ? null : () {
  //         showDialog(
  //           context: context,
  //           builder: (context) => GamesPresetDialog(
  //             onChanged: (value) {
  //               context.read<PreferencesBloc>()
  //                 .add(SaveGamesPreset(
  //                   gamesPreset: GamesPreset(
  //                     name: value, 
  //                     status: widget.status,
  //                     filter: _filter
  //                   )
  //                 ));
  //             },
  //           ),
  //           useRootNavigator: false,
  //         );
  //       },
  //     )
  //   );

  //   final createGameWidget = Tooltip(
  //     message: t.ui.gamesPage.addGameButton,
  //     child: IconButton(
  //       icon: const Icon(Icons.add),
  //       onPressed: () {
  //         final game = Game.create(
  //           title: t.ui.gamesPage.defaultGameTitle, 
  //           thumbUrl: null,
  //           status: widget.status,
  //         );

  //         context.read<GamesBloc>().add(SaveGame(game: game));

  //         GamesNavigator.goGame(context, id: game.id);
  //       },
  //     )
  //   );
      
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       HSpacer(size: SpaceSize.xxxl),
  //       searchWidget,
  //       HSpacer(size: SpaceSize.s),
  //       filterWidget,
  //       HSpacer(size: SpaceSize.s),
  //       savePresetWidget,
  //       HSpacer(size: SpaceSize.l),
  //       createGameWidget,
  //       HSpacer(size: SpaceSize.xl),
  //     ]
  //   );
  // }

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