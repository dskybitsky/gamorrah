import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/preferences/preferences.dart';
import 'package:gamorrah/pages/games_page_layout.dart';
import 'package:gamorrah/state/game/games_bloc.dart';

class GamesPage extends StatelessWidget {
  GamesPage({
    super.key,
    required this.status,
    this.presets = const []
  });

  final GameStatus status;
  final List<GamesPreset> presets;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, GamesState>(
      builder: (context, state) {
        if (state.phase.isInitial) {
          return Container();
        }

        if (state.phase.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.phase.isError) {
          return Center(
            child: Text(t.ui.general.errorText),
          );
        }
        
        return GamesPageLayout(
          gamesState: state,
          status: status, 
          presets: presets,
        );
      },
    );
  }
}