import 'package:flutter/material.dart';
import 'package:gamorrah/models/game/game.dart';

class GameThumb extends StatelessWidget {
  const GameThumb({
    super.key,
    required this.game,
    this.onPressed,
  });

  final Game game;
  final VoidCallback? onPressed;

  _isValidUrl(String url) {
    return Uri.parse(game.thumbUrl!).isAbsolute;
  }

  Widget _buildChild(BuildContext context) {
    String? thumbUrl = game.thumbUrl;

    if (thumbUrl == null || !_isValidUrl(thumbUrl)) {
      return SizedBox(
        width: 160,
        height: 200,
        child: ColoredBox(color: Colors.grey, )
      );
    }

    return Image.network(thumbUrl);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: _buildChild(context),
    );
  }
}