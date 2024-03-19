import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/pages/home_page_layout.dart';
import 'package:gamorrah/state/preferences/preferences_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
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
        
        return HomePageLayout(preferencesState: state);
      },
    );
  }
}