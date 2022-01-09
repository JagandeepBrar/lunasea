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
  LunaEnvironment get environment {
    if (kDebugMode) return LunaEnvironment.DEVELOP;
    switch (LunaFlavor.flavor) {
      case 'develop':
        return LunaEnvironment.DEVELOP;
      case 'alpha':
        return LunaEnvironment.ALPHA;
      case 'beta':
        return LunaEnvironment.BETA;
      case 'production':
        return LunaEnvironment.PRODUCTION;
    }
    throw Exception('Invalid LunaEnvironment');
  }

  /// Returns if the given flavor is "lower" than the given environment.
  /// For example, `alpha` is lower than `beta` but is not lower than `develop`.
  bool isLowerOrEqualTo(LunaEnvironment env) {
    if (this.environment == env) return true;
    switch (env) {
      case LunaEnvironment.DEVELOP:
        return false;
      case LunaEnvironment.ALPHA:
        return this.environment == LunaEnvironment.DEVELOP;
      case LunaEnvironment.BETA:
        return this.environment == LunaEnvironment.DEVELOP ||
            this.environment == LunaEnvironment.ALPHA;
      case LunaEnvironment.PRODUCTION:
        return true;
    }
  }
}

enum LunaEnvironment {
  DEVELOP,
  ALPHA,
  BETA,
  PRODUCTION,
}

extension LunaEnvironmentExtension on LunaEnvironment {
  String get key {
    switch (this) {
      case LunaEnvironment.DEVELOP:
        return _DEVELOP;
      case LunaEnvironment.ALPHA:
        return _ALPHA;
      case LunaEnvironment.BETA:
        return _BETA;
      case LunaEnvironment.PRODUCTION:
        return _PRODUCTION;
    }
  }

  String get name {
    switch (this) {
      case LunaEnvironment.DEVELOP:
        return 'lunasea.Develop'.tr();
      case LunaEnvironment.ALPHA:
        return 'lunasea.Alpha'.tr();
      case LunaEnvironment.BETA:
        return 'lunasea.Beta'.tr();
      case LunaEnvironment.PRODUCTION:
        return 'lunasea.Production'.tr();
    }
  }

  Color get color {
    switch (this) {
      case LunaEnvironment.DEVELOP:
        return LunaColours.red;
      case LunaEnvironment.ALPHA:
        return LunaColours.orange;
      case LunaEnvironment.BETA:
        return LunaColours.blue;
      case LunaEnvironment.PRODUCTION:
        return LunaColours.accent;
    }
  }

  LunaEnvironment from(String key) {
    switch (key) {
      case _DEVELOP:
        return LunaEnvironment.DEVELOP;
      case _ALPHA:
        return LunaEnvironment.ALPHA;
      case _BETA:
        return LunaEnvironment.BETA;
      case _PRODUCTION:
        return LunaEnvironment.PRODUCTION;
    }
    throw Exception('Unknown Flavor');
  }
}
