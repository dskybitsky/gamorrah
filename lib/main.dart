import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/models/game/hive_game_service.dart';
import 'package:gamorrah/screens/main.dart';
import 'package:get/instance_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GameService gameService = HiveGameService();

  await gameService.init();

  Get.put(gameService);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

   @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return FluentApp(
      title: 'Gamorrah',
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 181, 177, 235)),
      // ),
      home: MainScreen(),
    );
  }
}