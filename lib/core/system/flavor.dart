import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:envify/envify.dart';

part 'flavor.g.dart';

const _DEVELOP = 'develop';
const _ALPHA = 'alpha';
const _BETA = 'beta';
const _PRODUCTION = 'production';

@Envify(path: '.flavor')
class LunaFlavor {
  static const flavor = _LunaFlavor.flavor;
}

extension FlavorExtension on LunaFlavor {
  Environment get environment {
    if (kDebugMode) return Environment.DEVELOP;
    switch (LunaFlavor.flavor) {
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

  String get name {
    switch (this) {
      case Environment.DEVELOP:
        return 'lunasea.Develop'.tr();
      case Environment.ALPHA:
        return 'lunasea.Alpha'.tr();
      case Environment.BETA:
        return 'lunasea.Beta'.tr();
      case Environment.PRODUCTION:
        return 'lunasea.Production'.tr();
    }
  }

  Color get color {
    switch (this) {
      case Environment.DEVELOP:
        return LunaColours.red;
      case Environment.ALPHA:
        return LunaColours.orange;
      case Environment.BETA:
        return LunaColours.blue;
      case Environment.PRODUCTION:
        return LunaColours.accent;
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
