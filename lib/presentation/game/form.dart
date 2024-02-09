import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/game/game_service.dart';
import 'package:gamorrah/presentation/game/form_modal.dart';
import 'package:gamorrah/presentation/game/thumb.dart';
import 'package:gamorrah/presentation/main_screen_context.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class GameForm extends StatefulWidget {
  const GameForm({ 
    this.id,
  });

  final String? id;
  
  @override
  State<GameForm> createState() => _GameFormScreenState();
}

class _GameFormScreenState extends State<GameForm> with MainScreenContextUpdateMixin {
  late final String id;
  late final GameService service;

  late GamePersonalBeaten? _personalBeaten;
  late int? _personalTimeSpent;
  late double? _personalRating;
  late GameStatus _status;
  
  @override
  void initState() {
    super.initState();

    service = Get.find();

    Game game = _initGame();

    id = game.id;

    _personalBeaten = game.personal?.beaten;
    _personalRating = game.personal?.rating;
    _personalTimeSpent = game.personal?.timeSpent;
    _status = game.status;
  }

  Game _initGame() {
    String? widgetId = widget.id;

    if (widgetId != null) {
      return service.get(widgetId)!;
    }

    Game game = Game.create(title: "New Game", thumbUrl: null);

    service.save(game);

    return game;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: service, 
      builder: (context, widget) {
        Game? game = service.get(id);

        if (game == null) {
          return Container();
        }

        updateScreenContext((mainScreenContext) {
          mainScreenContext.appBarTitleNotifier.value = game.title;
          mainScreenContext.appBarActionsNotifier.value = _buildActions(game);
        });

        return ScaffoldPage(
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 6,
                  child: ListView(
                    children: [
                      GameThumb(
                        game: game,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => GameFormModal(game: game),
                            useRootNavigator: false,
                          );
                        }
                      ),
                      SizedBox(height: 32),
                      Container(
                        alignment: Alignment.centerLeft, 
                        child: Text('PERSONAL'),
                      ),
                      SizedBox(height: 8),
                      _buildFormRow('Beaten:', ComboBox<GamePersonalBeaten>(
                          value: _personalBeaten,
                          items: [
                            ComboBoxItem(value: GamePersonalBeaten.story, child: Text('Story')),
                            ComboBoxItem(value: GamePersonalBeaten.storySides, child: Text('Story + Sides')),
                            ComboBoxItem(value: GamePersonalBeaten.completionist, child: Text('Completionist')),
                          ],
                          onChanged: ( value) {
                            setState(() {
                              _personalBeaten = value;
                            });
                          },
                          isExpanded: true,
                        )),
                      SizedBox(height: 8),
                      _buildFormRow('Rating:', NumberBox(
                        placeholder: 'Rating',
                        value: _personalRating,
                        onChanged: (value) => { _personalRating = value },
                      )),
                      SizedBox(height: 8),
                      _buildFormRow('Time Spent:', NumberBox(
                        placeholder: 'Hours',
                        value: _personalTimeSpent,
                        onChanged: (value) => { _personalTimeSpent = value },
                      )),
                      SizedBox(height: 32),
                      _buildFormRow('Status:', ComboBox<GameStatus>(
                          value: _status,
                          items: [
                            ComboBoxItem(value: GameStatus.backlog, child: Text('Backlog')),
                            ComboBoxItem(value: GameStatus.playing, child: Text("Playing")),
                            ComboBoxItem(value: GameStatus.finished, child: Text("Finished")),
                            ComboBoxItem(value: GameStatus.wishlist, child: Text("Wishlist")),
                          ],
                          onChanged: ( value) {
                            setState(() {
                              _status = value ?? GameStatus.backlog;
                            });
                          },
                          isExpanded: true,
                        )
                      ),
                      SizedBox(height: 16),
                      FilledButton(
                        onPressed: () {
                          service.save(game.copyWith(
                            status: _status,
                            personal: game.copyPersonalWith(
                              beaten: _personalBeaten,
                              rating: _personalRating,
                              timeSpent: _personalTimeSpent,
                            )
                          ));
                          Navigator.pop(context);
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 2, child: Container()),
              ],
            ),
          ),
        ); 
      }
    );
  }

  Widget _buildFormRow(String label, Widget child) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Expanded(child: child),
      ] 
    );
  }

  Widget _buildActions(Game game) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 48),
          child: 
            CommandBar(
              mainAxisAlignment: MainAxisAlignment.end,
              primaryItems: [
                CommandBarButton(
                  icon: const Icon(FluentIcons.delete),
                  label: const Text('Delete'),
                  onPressed: () {
                    service.delete(game.id);
                    Navigator.pop(context);
                  },
                ),
              ],
            )
        )
      ]
    );
  }
}