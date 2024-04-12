import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game_db/i18n/strings.g.dart';
import 'package:my_game_db/models/game/game.dart';
import 'package:my_game_db/state/game/games_bloc.dart';
import 'package:my_game_db/widgets/ui/confirmation_dialog.dart';
import 'package:my_game_db/widgets/ui/notification_dialog.dart';
import 'package:my_game_db/widgets/ui/spacer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, GamesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(t.ui.settingsPage.settingsTitle),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(flex: 3, child: _buildContent(context)),
                Expanded(flex: 1, child: Container()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 16, right: 16),
      children: [
        Row(
          children: [
            Icon(Icons.file_upload, size: 24.0),
            HSpacer(),
            Expanded(child: OutlinedButton(
              onPressed: () {
                _handleImport(context);
              },
              child: Text(t.ui.settingsPage.importFromJsonButton),
            )),
          ],
        ),        
        VSpacer(),
        Row(
          children: [
            Icon(Icons.file_download, size: 24.0),
            HSpacer(),
            Expanded(child: OutlinedButton(
              onPressed: () {
                _handleExport(context);
              },
              child: Text(t.ui.settingsPage.exportToJsonButton),
            )),
          ],
        ),
        VSpacer(),
        Row(
          children: [
            Icon(Icons.delete, size: 24.0),
            HSpacer(),
            Expanded(child: FilledButton(
              onPressed: () async {
                _handleDeleteAll(context);
              },
              child: Text(t.ui.settingsPage.deleteAllGamesButton),
            )),
          ],
        ),
      ],
    );
  }

  void _handleImport(BuildContext context) async {
    FilePickerResult? inputFile = await FilePicker.platform.pickFiles();

    if (inputFile == null) {
      return;
    }

    if (!context.mounted) {
      return;
    }

    File file = File(inputFile.files.single.path!);

    final json = file.readAsStringSync();

    final data = jsonDecode(json);

    final gamesData = data['games'] as List;

    final games = gamesData
      .map((gameData) => Game.fromJson(gameData))
      .toList();

    context.read<GamesBloc>().add(SaveGames(games: games));

    showDialog(
      context: context,
      builder: (_) {
        return NotificationDialog(
          message: t.ui.settingsPage.importFromJsonSuccessMessage
        );
      }
    );
  }

  void _handleExport(BuildContext context) async {
    String? outputFile = await FilePicker.platform.saveFile(
      fileName: 'my_game_db.json',
    );

    if (outputFile == null) {
      return;
    }

    if (!context.mounted) {
      return;
    }

    File file = File(outputFile);

    final games = context.read<GamesBloc>().state.games.toList();

    games.sort((gameA, gameB) => gameA.title.compareTo(gameB.title));

    final data = { 
      'games': games.map((e) => e.toJson()).toList(),
    };

    file.writeAsStringSync(jsonEncode(data));
    
    showDialog(
      context: context,
      builder: (_) {
        return NotificationDialog(
          message: t.ui.settingsPage.exportToJsonSuccessMessage
        );
      }
    );
  }

  void _handleDeleteAll(BuildContext context) async {
    final block = context.read<GamesBloc>();

    showDialog(
      context: context, 
      builder: (context) {
        return ConfirmationDialog(
          message: t.ui.settingsPage.deleteAllGamesConfirmationMessage,
          callback: () async {
            block.add(DeleteAllGames());
          }
        );
      }
    );
  }
}