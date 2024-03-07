import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/models/game/game_repository.dart';
import 'package:gamorrah/models/game/hive_game_repository.dart';
import 'package:gamorrah/models/preferences/hive_preferences_repository.dart';
import 'package:gamorrah/models/preferences/preferences_repository.dart';
import 'package:gamorrah/pages/home_page_layout.dart';
import 'package:gamorrah/state/game/games_bloc.dart';
import 'package:gamorrah/state/preferences/preferences_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MultiRepositoryProvider(
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
          child: HomePageLayout(),
        ),
      ),
    );
  }
}