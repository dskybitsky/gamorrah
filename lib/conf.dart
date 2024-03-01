enum Environment { live, dev }

class EnvironmentConfig {
  static const _env = String.fromEnvironment('ENV', defaultValue: 'live');

  static const Environment env  = _env == 'dev' ? Environment.dev : Environment.live;
  
  static const bool isDev = env == Environment.dev;
}
