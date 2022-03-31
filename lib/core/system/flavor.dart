import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:envify/envify.dart';

part 'flavor.g.dart';

const _EDGE = 'edge';
const _BETA = 'beta';
const _CANDIDATE = 'candidate';
const _STABLE = 'stable';

@Envify(path: '.flavor')
class LunaFlavor {
  static const flavor = _LunaFlavor.flavor;
  static const commit = _LunaFlavor.commit;
}

extension FlavorExtension on LunaFlavor {
  LunaEnvironment get environment {
    switch (LunaFlavor.flavor) {
      case _EDGE:
        return LunaEnvironment.EDGE;
      case _BETA:
        return LunaEnvironment.BETA;
      case _CANDIDATE:
        return LunaEnvironment.CANDIDATE;
      case _STABLE:
        return LunaEnvironment.STABLE;
    }
    throw Exception('Invalid LunaEnvironment');
  }

  String get shortCommit {
    return LunaFlavor.commit.substring(0, min(7, LunaFlavor.commit.length));
  }

  Future<void> openCommitHistory() async {
    String _base = 'https://github.com/JagandeepBrar/LunaSea/commits';
    return '$_base/${LunaFlavor.commit}'.lunaOpenGenericLink();
  }

  /// Returns if the given flavor is "lower" than the given environment.
  /// For example, `alpha` is lower than `beta` but is not lower than `develop`.
  bool isLowerOrEqualTo(LunaEnvironment env) {
    if (this.environment == env) return true;
    switch (env) {
      case LunaEnvironment.EDGE:
        return false;
      case LunaEnvironment.BETA:
        return this.environment == LunaEnvironment.EDGE;
      case LunaEnvironment.CANDIDATE:
        return this.environment == LunaEnvironment.EDGE ||
            this.environment == LunaEnvironment.BETA;
      case LunaEnvironment.STABLE:
        return true;
    }
  }
}

enum LunaEnvironment {
  EDGE,
  BETA,
  CANDIDATE,
  STABLE,
}

extension LunaEnvironmentExtension on LunaEnvironment {
  String get key {
    switch (this) {
      case LunaEnvironment.EDGE:
        return _EDGE;
      case LunaEnvironment.BETA:
        return _BETA;
      case LunaEnvironment.CANDIDATE:
        return _CANDIDATE;
      case LunaEnvironment.STABLE:
        return _STABLE;
    }
  }

  String get name {
    switch (this) {
      case LunaEnvironment.EDGE:
        return 'lunasea.Edge'.tr();
      case LunaEnvironment.BETA:
        return 'lunasea.Beta'.tr();
      case LunaEnvironment.CANDIDATE:
        return 'lunasea.Candidate'.tr();
      case LunaEnvironment.STABLE:
        return 'lunasea.Stable'.tr();
    }
  }

  Color get color {
    switch (this) {
      case LunaEnvironment.EDGE:
        return LunaColours.red;
      case LunaEnvironment.BETA:
        return LunaColours.orange;
      case LunaEnvironment.CANDIDATE:
        return LunaColours.blue;
      case LunaEnvironment.STABLE:
        return LunaColours.accent;
    }
  }

  LunaEnvironment from(String key) {
    switch (key) {
      case _EDGE:
        return LunaEnvironment.EDGE;
      case _BETA:
        return LunaEnvironment.BETA;
      case _CANDIDATE:
        return LunaEnvironment.CANDIDATE;
      case _STABLE:
        return LunaEnvironment.STABLE;
    }
    throw Exception('Unknown Flavor');
  }
}
