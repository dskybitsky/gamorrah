import 'package:flutter/material.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/models/game/hive_game_service.dart';
import 'package:gamorrah/screens/games_list.dart';
import 'package:get/instance_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
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
    
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 181, 177, 235)),
      ),
      home: GamesListScreen(),
    );
  }
}