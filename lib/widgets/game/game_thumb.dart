import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_icon.dart';

enum GameThumbType { small, medium, large }

class GameThumb extends StatelessWidget {
  const GameThumb({
    super.key,
    required this.game,
    required this.type,
    this.onPressed,
  });

  final Game game;
  final GameThumbType type;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: _buildImage(context),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    String? thumbUrl = game.thumbUrl;
    final size = _getSize();

    if (thumbUrl == null || !_isValidUrl(thumbUrl)) {
      return Container(
        height: size.height,
        width: size.width,
        decoration: _buildBoxDecoration(context, null),
      );
    }
    
    return CachedNetworkImage(
      imageUrl: thumbUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: size.height,
        width: size.width,
        decoration: _buildBoxDecoration(
          context,
          DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
        child: _getOverlay(context),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
    );
  }

  Widget? _getOverlay(BuildContext context) {
    final beaten = game.personal?.beaten;

    if (beaten == null) {
      return null;
    }

    final size = type == GameThumbType.small
      ? Size(24, 24)
      : Size(32, 32);
    
    final padding = type == GameThumbType.small
      ? EdgeInsets.only(right: 6.0, top: 6.0)
      : EdgeInsets.only(right: 8.0, top: 8.0);

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: padding,
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[900]!.withOpacity(0.6),
          ),
          child: Center(
            child: GamePersonalBeatenIcon(
              value: beaten,
            ),
          ),
        )
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(BuildContext context, DecorationImage? decorationImage) {
    final borderRadius = type == GameThumbType.small
      ? BorderRadius.circular(6)
      : BorderRadius.circular(12);

    return BoxDecoration(
      borderRadius: borderRadius,
      boxShadow: [
        BoxShadow(
          color: _getShadowColor(context).withOpacity(.6),
          spreadRadius: 3.0,
          blurRadius: 7.0,
          offset: Offset(0, 0),
        ),
      ],
      color: Colors.grey,
      image: decorationImage,
    );
  }

  Color _getShadowColor(BuildContext context) {
    return switch (game.kind) {
      GameKind.bundle => Colors.blue,
      GameKind.dlc => Colors.green,
      GameKind.content => Colors.orange,
      _ => Colors.grey[600],
    }!;
  }

  Size _getSize() => switch (type) {
    (GameThumbType.small) => Size(90, 120),
    (GameThumbType.medium) => Size(150, 200),
    (GameThumbType.large) => Size(264, 352),
  };

  _isValidUrl(String url) {
    return Uri.parse(game.thumbUrl!).isAbsolute;
  }
}