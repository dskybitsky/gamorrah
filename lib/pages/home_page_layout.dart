import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/pages/settings_page.dart';
import 'package:gamorrah/state/preferences/preferences_bloc.dart';
import 'package:gamorrah/widgets/game/games_navigator.dart';

class HomePageLayout extends StatefulWidget {
  final int initialPage;

  const HomePageLayout({
    super.key,
    this.initialPage = 0,
  });

  @override
  State<HomePageLayout> createState() => _HomePageLayoutState();
}

class _HomePageLayoutState extends State<HomePageLayout> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
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

  Widget _buildContent(BuildContext context, PreferencesState state) {
    return NavigationView(
      pane: NavigationPane(
        selected: _page,
        onChanged: _onPageChanged,
        displayMode: PaneDisplayMode.compact,
        items: [
          _buildGamesPaneItem(context, state, GameStatus.backlog),
          _buildGamesPaneItem(context, state, GameStatus.playing),
          _buildGamesPaneItem(context, state, GameStatus.finished),
          _buildGamesPaneItem(context, state, GameStatus.wishlist),   
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: Text(t.ui.homePage.settingsLink),
            body: SettingsPage(),
          ),
        ],
      ),
    );
  }

  PaneItem _buildGamesPaneItem(BuildContext context, PreferencesState state, GameStatus status) {
    final icon = switch (status) {
      GameStatus.backlog => const Icon(FluentIcons.history),
      GameStatus.playing => const Icon(FluentIcons.play),
      GameStatus.finished => const Icon(FluentIcons.completed),
      GameStatus.wishlist => const Icon(FluentIcons.waitlist_confirm),
    };

    final title = switch (status) {
      GameStatus.backlog => Text(t.types.gameStatus.backlog),
      GameStatus.playing => Text(t.types.gameStatus.playing),
      GameStatus.finished => Text(t.types.gameStatus.finished),
      GameStatus.wishlist => Text(t.types.gameStatus.wishlist),
    };

    final presets = state.preferences.gamesPresets
      .where((gamesPreset) => gamesPreset.status == status);

    if (presets.isEmpty) {
      return PaneItem(icon: icon, title: title, body: GamesNavigator(
        status: status,
      ));
    }

    final items = presets
      .map((gamesPreset) => PaneItem(
        icon: icon, 
        title: Text(gamesPreset.name),
        body: GamesNavigator(status: status, preset: gamesPreset)
      ))
      .toList();

    return PaneItemExpander(icon: icon, title: title, items: items, 
      body: GamesNavigator(status: status)
    );
  }

  void _onPageChanged(int page) {
    setState(() => _page = page);
  }
}