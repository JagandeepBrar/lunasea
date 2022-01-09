const _DEVELOP = 'develop';
const _ALPHA = 'alpha';
const _BETA = 'beta';
const _PRODUCTION = 'production';

enum Environment {
  DEVELOP,
  ALPHA,
  BETA,
  PRODUCTION,
}

extension EnvironmentExtension on Environment {
  String get key {
    switch (this) {
      case Environment.DEVELOP:
        return _DEVELOP;
      case Environment.ALPHA:
        return _ALPHA;
      case Environment.BETA:
        return _BETA;
      case Environment.PRODUCTION:
        return _PRODUCTION;
    }
  }

  Environment from(String key) {
    switch (key) {
      case _DEVELOP:
        return Environment.DEVELOP;
      case _ALPHA:
        return Environment.ALPHA;
      case _BETA:
        return Environment.BETA;
      case _PRODUCTION:
        return Environment.PRODUCTION;
    }
    throw Exception('Unknown Flavor');
  }
}
