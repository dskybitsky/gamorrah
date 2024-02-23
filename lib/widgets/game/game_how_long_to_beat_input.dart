import 'package:fluent_ui/fluent_ui.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/widgets/ui/labeled_input.dart';

class GameHowLongToBeatInput extends StatelessWidget {
  const GameHowLongToBeatInput({
    super.key,
    required this.value,
    this.onChanged,
  });

  final GameHowLongToBeat value;
  final void Function(GameHowLongToBeat)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expander(
      header: Text('HowLongToBeat'),
      content: Column(
        children: [
          LabeledInput(label: Text('Story'), child: NumberBox(
            placeholder: 'Hours',
            value: value.story,
            onChanged: _onStoryChanged,
          )),
          SizedBox(height: 16),
          LabeledInput(label: Text('Story + Sidex'), child: NumberBox(
            placeholder: 'Hours',
            value: value.storySides,
            onChanged: _onStorySidesChanged,
          )),
          SizedBox(height: 16),
          LabeledInput(label: Text('Completionist'), child: NumberBox(
            placeholder: 'Hours',
            value: value.completionist,
            onChanged: _onCompletionistChanged,
          )),
        ],
      )
    );
  }

  void _onStoryChanged(double? story) {
    if (onChanged != null) {
      onChanged!(value.copyWith(story: Optional(story)));
    }
  }

  void _onStorySidesChanged(double? storySides) {
    if (onChanged != null) {
      onChanged!(value.copyWith(storySides: Optional(storySides)));
    }
  }

  void _onCompletionistChanged(double? completionist) {
    if (onChanged != null) {
      onChanged!(value.copyWith(completionist: Optional(completionist)));
    }
  }
}