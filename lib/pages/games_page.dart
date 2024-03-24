import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/pages/games_page_layout.dart';
import 'package:gamorrah/state/game/games_bloc.dart';
import 'package:gamorrah/state/games_view/games_views_bloc.dart';
import 'package:gamorrah/state/state_phase.dart';

class GamesPage extends StatelessWidget {
  GamesPage({
    super.key,
    required this.status,
  });

  final GameStatus status;

  @override
  Widget build(BuildContext context) {
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
            
            return GamesPageLayout(
              gamesState: gamesState,
              gamesViewsState: gamesViewsState, 
              status: status,
            );
          },
        );
      }
    );
  }
}