import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game_db/i18n/strings.g.dart';
import 'package:my_game_db/models/game/game_repository.dart';
import 'package:my_game_db/models/game/hive_game.dart';
import 'package:my_game_db/models/game/hive_game_repository.dart';
import 'package:my_game_db/models/games_view/games_view_repository.dart';
import 'package:my_game_db/models/games_view/hive_games_view.dart';
import 'package:my_game_db/models/games_view/hive_games_view_repository.dart';
import 'package:my_game_db/models/settings/hive_settings.dart';
import 'package:my_game_db/models/settings/hive_settings_repository.dart';
import 'package:my_game_db/models/settings/settings.dart';
import 'package:my_game_db/models/settings/settings_repository.dart';
import 'package:my_game_db/state/game/games_bloc.dart';
import 'package:my_game_db/state/games_view/games_views_bloc.dart';
import 'package:my_game_db/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_game_db/state/settings/settings_bloc.dart';
import 'package:my_game_db/state/state_phase.dart';
import 'package:my_game_db/themes.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  SystemTheme.accentColor.load();

  WidgetsFlutterBinding.ensureInitialized();

  LocaleSettings.useDeviceLocale();

  await _initHive();
  await _initWindow();

  runApp(MyApp());
}

Future<void> _initHive() async {
  Hive.registerAdapter(HiveGameAdapter());
  Hive.registerAdapter(HiveSettingsAdapter());
  Hive.registerAdapter(HiveGamesViewAdapter());
  Hive.registerAdapter(HiveGamesFilterAdapter());
  Hive.registerAdapter(HiveGamesFilterPlatformsPredicateAdapter());
  Hive.registerAdapter(HiveGamesFilterBeatenPredicateAdapter());
  Hive.registerAdapter(HiveGamesFilterHowLongToBeatPredicateAdapter());
  Hive.registerAdapter(HiveGamesFilterTagsPredicateAdapter());

  await Hive.initFlutter();
}

Future<void> _initWindow() async {
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(800, 600),
    minimumSize: Size(600, 400),
    center: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SettingsRepository>(
      create: (context) => HiveSettingsRepository(),
      child: BlocProvider(
        create: (context) => SettingsBloc(
          settingsRepository: context.read<SettingsRepository>()
        )..add(LoadSettings()),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) => state.phase.isSuccess 
            ? _appBuilder(context, state.settings)
            : Container(),
        ),
      ),
    );
  }

  Widget _appBuilder(BuildContext context, Settings settings) {
    return MaterialApp(
      title: 'My Game DB',
      theme: settings.theme ?? Themes.theme,
      darkTheme: settings.darkTheme ?? Themes.darkTheme,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<GameRepository>(
            create: (context) => HiveGameRepository(),
          ),
          RepositoryProvider<GamesViewRepository>(
            create: (context) => HiveGamesViewRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<GamesBloc>(
              create: (context) => GamesBloc(
                gameRepository: context.read<GameRepository>(),
              )..add(LoadGames()),
            ),
            BlocProvider<GamesViewsBloc>(
              create: (context) => GamesViewsBloc(
                gamesViewRepository: context.read<GamesViewRepository>(),
              )..add(LoadGamesViews()),
            ),            
          ],
          child: HomePage(),
        ),
      ),
    );
  }
}