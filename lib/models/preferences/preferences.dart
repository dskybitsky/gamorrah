import 'package:my_game_db/models/optional.dart';

class Preferences {
  const Preferences({
    this.dataDir,
  });

  final String? dataDir;

  Preferences copyWith({
    Optional<String?>? dataDir
  }) => Preferences(
    dataDir: dataDir != null ? dataDir.value : this.dataDir,
  );
}
