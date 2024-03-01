import 'package:fluent_ui/fluent_ui.dart';

class GamePersonalRatingInput extends StatelessWidget {
  const GamePersonalRatingInput({
    super.key,
    required this.value,
    this.onChanged,
  });

  final double? value;
  final void Function(double?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      rating: value ?? 0,
      unratedIconColor: FluentTheme.of(context).inactiveBackgroundColor,
      onChanged: (value) {
        final onChanged = this.onChanged;

        if (onChanged != null) {
          onChanged((value * 2).round() / 2 );
        }
      },
    );
  }
}