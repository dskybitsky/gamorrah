import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/state/game/games_bloc.dart';
import 'package:gamorrah/widgets/ui/confirmation_dialog.dart';
import 'package:gamorrah/widgets/ui/hspacer.dart';
import 'package:gamorrah/widgets/ui/notification_dialog.dart';
import 'package:gamorrah/widgets/ui/vspacer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, GamesState>(
      builder: (context, state) {
        return NavigationView(
          appBar: NavigationAppBar(
              title: Text(t.ui.settingsPage.settingsTitle),
              automaticallyImplyLeading: false,
          ),
          content: ScaffoldPage(
            content: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(flex: 3, child: _buildContent(context)),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
          )
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
            Icon(FluentIcons.import, size: 24.0),
            HSpacer(),
            Expanded(child: Button(
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
            Icon(FluentIcons.export, size: 24.0),
            HSpacer(),
            Expanded(child: Button(
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
            Icon(FluentIcons.delete, size: 24.0),
            HSpacer(),
            Expanded(child: FilledButton(
              style: ButtonStyle(
                backgroundColor: ButtonState.all(Colors.warningPrimaryColor),
              ),
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
      fileName: 'Gamorrah.json',
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