import 'package:flutter/material.dart';
import 'package:gamorrah/models/game/game.dart';

enum GameThumbSize { small, medium, large }

class GameThumb extends StatelessWidget {
  const GameThumb({
    super.key,
    required this.game,
    required this.size,
    this.onPressed,
  });

  final Game game;
  final GameThumbSize size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          height: _getHeight(),
          width: _getWidth(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: _getShadowColor(),
                offset: const Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 5.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
            color: Colors.grey,
            image: _getDecorationImage(),
          ),
        ),
      ),
    );
  }

  Color _getShadowColor() {
    return switch (game.kind) {
      GameKind.bundle => Colors.blue,
      GameKind.dlc => Colors.green,
      GameKind.content => Colors.orange,
      _ => Colors.grey,
    };
  }

  double _getHeight() {
    return switch (size) {
      GameThumbSize.small => 120,
      GameThumbSize.medium => 200,
      GameThumbSize.large => 352,
    };
  }

  double _getWidth() {
    return switch (size) {
      GameThumbSize.small => 90,
      GameThumbSize.medium => 150,
      GameThumbSize.large => 264,
    };
  }

  DecorationImage? _getDecorationImage() {
    String? thumbUrl = game.thumbUrl;

    if (thumbUrl == null || !_isValidUrl(thumbUrl)) {
      return null;
    }

    return DecorationImage(
      image: NetworkImage(thumbUrl),
      fit: BoxFit.fill,
    );
  }

  _isValidUrl(String url) {
    return Uri.parse(game.thumbUrl!).isAbsolute;
  }
}