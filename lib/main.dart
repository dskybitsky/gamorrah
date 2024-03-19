import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game_repository.dart';
import 'package:gamorrah/models/game/hive_game.dart';
import 'package:gamorrah/models/game/hive_game_repository.dart';
import 'package:gamorrah/models/preferences/hive_preferences.dart';
import 'package:gamorrah/models/preferences/hive_preferences_repository.dart';
import 'package:gamorrah/models/preferences/preferences_repository.dart';
import 'package:gamorrah/state/game/games_bloc.dart';
import 'package:gamorrah/theme.dart';
import 'package:gamorrah/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'state/preferences/preferences_bloc.dart';

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
  Hive.registerAdapter(HivePreferencesAdapter());
  Hive.registerAdapter(HiveGamesPresetAdapter());
  Hive.registerAdapter(HiveGamesFilterAdapter());

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
  final _appTheme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _appTheme,
      builder: (context, child) {
        final appTheme = context.watch<AppTheme>();

        return MaterialApp(
          title: 'Gamorrah',
          // darkTheme: FluentThemeData(
          //   brightness: Brightness.dark,
          //   accentColor: appTheme.color,
          //   visualDensity: VisualDensity.standard,
          //   focusTheme: FocusThemeData(
          //     glowFactor: is10footScreen(context) ? 2.0 : 0.0,
          //   ),
          // ),
          // theme: FluentThemeData(
          //   accentColor: appTheme.color,
          //   visualDensity: VisualDensity.standard,
          //   focusTheme: FocusThemeData(
          //     glowFactor: is10footScreen(context) ? 2.0 : 0.0,
          //   ),
          // ),
          locale: appTheme.locale,
          home: MultiRepositoryProvider(
            providers: [
              RepositoryProvider<GameRepository>(
                create: (context) => HiveGameRepository(),
              ),
              RepositoryProvider<PreferencesRepository>(
                create: (context) => HivePreferencesRepository(),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<GamesBloc>(
                  create: (context) => GamesBloc(
                    gameRepository: context.read<GameRepository>(),
                  )..add(LoadGames()),
                ),
                BlocProvider<PreferencesBloc>(
                  create: (context) => PreferencesBloc(
                    preferencesRepository: context.read<PreferencesRepository>(),
                  )..add(LoadPrefernces()),
                ),
              ],
              child: HomePage(),
            ),
          ),
        );
      }
    );
  }
}