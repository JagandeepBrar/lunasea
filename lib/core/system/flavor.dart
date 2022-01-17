import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:envify/envify.dart';

part 'flavor.g.dart';

const _INTERNAL = 'internal';
const _ALPHA = 'alpha';
const _BETA = 'beta';
const _PRODUCTION = 'production';

@Envify(path: '.flavor')
class LunaFlavor {
  static const flavor = _LunaFlavor.flavor;
  static const commit = _LunaFlavor.commit;
}

extension FlavorExtension on LunaFlavor {
  LunaEnvironment get environment {
    if (kDebugMode) return LunaEnvironment.INTERNAL;
    switch (LunaFlavor.flavor) {
      case _INTERNAL:
        return LunaEnvironment.INTERNAL;
      case _ALPHA:
        return LunaEnvironment.ALPHA;
      case _BETA:
        return LunaEnvironment.BETA;
      case _PRODUCTION:
        return LunaEnvironment.PRODUCTION;
    }
    throw Exception('Invalid LunaEnvironment');
  }

  String get shortCommit => LunaFlavor.commit.substring(0, 7);

  Future<void> openCommitHistory() async {
    String _base = 'https://github.com/CometTools/LunaSea/commits';
    return '$_base/${LunaFlavor.commit}'.lunaOpenGenericLink();
  }

  /// Returns if the given flavor is "lower" than the given environment.
  /// For example, `alpha` is lower than `beta` but is not lower than `develop`.
  bool isLowerOrEqualTo(LunaEnvironment env) {
    if (this.environment == env) return true;
    switch (env) {
      case LunaEnvironment.INTERNAL:
        return false;
      case LunaEnvironment.ALPHA:
        return this.environment == LunaEnvironment.INTERNAL;
      case LunaEnvironment.BETA:
        return this.environment == LunaEnvironment.INTERNAL ||
            this.environment == LunaEnvironment.ALPHA;
      case LunaEnvironment.PRODUCTION:
        return true;
    }
  }
}

enum LunaEnvironment {
  INTERNAL,
  ALPHA,
  BETA,
  PRODUCTION,
}

extension LunaEnvironmentExtension on LunaEnvironment {
  String get key {
    switch (this) {
      case LunaEnvironment.INTERNAL:
        return _INTERNAL;
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
      case LunaEnvironment.INTERNAL:
        return 'lunasea.Internal'.tr();
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
      case LunaEnvironment.INTERNAL:
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
      case _INTERNAL:
        return LunaEnvironment.INTERNAL;
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
