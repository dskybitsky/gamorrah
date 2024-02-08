import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/models/game/hive_game_service.dart';
import 'package:gamorrah/presentation/main_screen.dart';
import 'package:gamorrah/theme.dart';
import 'package:get/instance_manager.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';

void main() async {
  GameService gameService = HiveGameService();

  await gameService.init();

  Get.put(gameService);

  SystemTheme.accentColor.load();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final _appTheme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _appTheme,
      builder: (context, child) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: 'Gamorrah',
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          theme: FluentThemeData(
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          locale: appTheme.locale,
          home: MainScreen(),
        );
      }
    );
  }
}