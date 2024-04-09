import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GamePersonalRatingBar extends StatelessWidget {
  const GamePersonalRatingBar({
    super.key,
    required this.value,
    this.onChanged,
  });

  final double? value;
  final void Function(double?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      allowHalfRating: true,
      initialRating: value ?? 0,
      onRatingUpdate: (value) {
        final onChanged = this.onChanged;

        if (onChanged != null) {
          onChanged((value * 2).round() / 2 );
        }
      },
    );
  }
}