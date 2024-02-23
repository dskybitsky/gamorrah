import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_input.dart';
import 'package:gamorrah/widgets/game/game_personal_rating_input.dart';
import 'package:gamorrah/widgets/ui/labeled_input.dart';

class GamePersonalInput extends StatelessWidget {
  const GamePersonalInput({
    super.key,
    required this.value,
    this.onChanged,
  });

  final GamePersonal value;
  final void Function(GamePersonal)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expander(
      header: Text('Personal'),
      content: Column(
        children: [
          LabeledInput(label: Text('Beaten'), child: GamePersonalBeatenInput(
            value: value.beaten, 
            onChanged: _onBeatenChanged,
          )),
          SizedBox(height: 16),
          LabeledInput(label: Text('Rating'), child: GamePersonalRatingInput(
            value: value.rating, 
            onChanged: _onRatingChanged,
          )),
          SizedBox(height: 16),
          LabeledInput(label: Text('Time Spent'), child: NumberBox(
            placeholder: 'Hours',
            value: value.timeSpent,
            onChanged: _onTimeSpentChanged
          )),
        ],
      )
    );
  }

  void _onBeatenChanged(GamePersonalBeaten? beaten) {
    if (onChanged != null) {
      onChanged!(value.copyWith(beaten: Optional(beaten)));
    }
  }

  void _onRatingChanged(double? rating) {
    if (onChanged != null) {
      onChanged!(value.copyWith(rating: Optional(rating)));
    }
  }

  void _onTimeSpentChanged(double? timeSpent) {
    if (onChanged != null) {
      onChanged!(value.copyWith(timeSpent: Optional(timeSpent)));
    }
  }
}