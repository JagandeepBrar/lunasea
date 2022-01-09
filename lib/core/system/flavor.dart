import 'package:envify/envify.dart';

part 'flavor.g.dart';

const _DEVELOP = 'develop';
const _ALPHA = 'alpha';
const _BETA = 'beta';
const _PRODUCTION = 'production';

@Envify(path: '.flavor')
abstract class Flavor {
  static const flavor = _Flavor.flavor;
}

extension FlavorExtension on Flavor {
  Environment get environment {
    switch (Flavor.flavor) {
      case 'develop':
        return Environment.DEVELOP;
      case 'alpha':
        return Environment.ALPHA;
      case 'beta':
        return Environment.BETA;
      case 'production':
        return Environment.PRODUCTION;
    }
    throw Exception('Invalid Environment');
  }
}

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
