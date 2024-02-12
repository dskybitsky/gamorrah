import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen();

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final GameService service;
  
  @override
  void initState() {
    super.initState();

    service = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: service, 
      builder: (context, widget) {
        return NavigationView(
          appBar: NavigationAppBar(
              title: Text('Settings'),
          ),
          content: ScaffoldPage(
            content: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(flex: 3, child: _buildContent()),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
          )
        ); 
      }
    );
  }

  Widget _buildContent() {
    return ListView(
      padding: EdgeInsets.only(left: 16, right: 16),
      children: [
        Button(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              File file = File(result.files.single.path!);

              final json = file.readAsStringSync();

              await service.importJson(json);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(FluentIcons.import, size: 24.0),
              SizedBox(width: 16),
              Text('Import from JSON'),
            ]
          ),
        ),
        SizedBox(height: 16),
        Button(
          onPressed: () async {
            String? outputFile = await FilePicker.platform.saveFile(
              fileName: 'gamorrah.json',
            );

            if (outputFile != null) {
              File file = File(outputFile);

              final json = service.exportJson();

              file.writeAsStringSync(json);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(FluentIcons.export, size: 24.0),
              SizedBox(width: 16),
              Text('Export to JSON'),
            ]
          ),
        ),
        SizedBox(height: 16),
        FilledButton(
          onPressed: () async {
            service.clear();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(FluentIcons.delete, size: 24.0,),
              SizedBox(width: 16),
              Text('Clear database'),
            ]
          ),
        ),
      ],
    );
  }
}