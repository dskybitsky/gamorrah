import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent_ui/fluent_ui.dart';
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
        child: _buildImage(context),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    String? thumbUrl = game.thumbUrl;

    if (thumbUrl == null || !_isValidUrl(thumbUrl)) {
      return Container(
        height: _getHeight(),
        width: _getWidth(),
        decoration: _buildBoxDecoration(context, null),
      );
    }

    return CachedNetworkImage(
        imageUrl: thumbUrl,
        imageBuilder: (context, imageProvider) => Container(
          height: _getHeight(),
          width: _getWidth(),
          decoration: _buildBoxDecoration(
            context,
            DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        placeholder: (context, url) => ProgressRing(),
      );
  }

  BoxDecoration _buildBoxDecoration(BuildContext context, DecorationImage? decorationImage) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _getShadowColor(context),
          offset: const Offset(1.0, 1.0),
          blurRadius: 5.0,
          spreadRadius: 2.0,
        ),
      ],
      color: Colors.grey,
      image: decorationImage,
    );
  }

  Color _getShadowColor(BuildContext context) {
    final isDark = FluentTheme.of(context).brightness.isDark;

    return switch (game.kind) {
      GameKind.bundle => Colors.blue,
      GameKind.dlc => Colors.green,
      GameKind.content => Colors.orange,
      _ => isDark ? Colors.grey[220] : Colors.grey[100],
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

  _isValidUrl(String url) {
    return Uri.parse(game.thumbUrl!).isAbsolute;
  }
}