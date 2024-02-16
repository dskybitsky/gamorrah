import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/models/game/game_repository.dart';
import 'package:gamorrah/models/game/hive_game_repository.dart';
import 'package:gamorrah/pages/home_page_layout.dart';
import 'package:gamorrah/state/game/games_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: RepositoryProvider<GameRepository>(
        create: (context) => HiveGameRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<GamesBloc>(
              create: (context) => GamesBloc(
                gameRepository: context.read<GameRepository>(),
              ),
            ),
          ],
          child: HomePageLayout(),
        ),
      ),
    );
  }
}