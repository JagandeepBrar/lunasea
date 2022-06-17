import 'package:flutter/material.dart';
import 'package:lunasea/system/environment.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';

const FLAVOR_EDGE = 'edge';
const FLAVOR_BETA = 'beta';
const FLAVOR_CANDIDATE = 'candidate';
const FLAVOR_STABLE = 'stable';

enum LunaFlavor {
  EDGE(FLAVOR_EDGE),
  BETA(FLAVOR_BETA),
  CANDIDATE(FLAVOR_CANDIDATE),
  STABLE(FLAVOR_STABLE);

  final String key;
  const LunaFlavor(this.key);

  static LunaFlavor fromKey(String key) {
    switch (key) {
      case FLAVOR_EDGE:
        return LunaFlavor.EDGE;
      case FLAVOR_BETA:
        return LunaFlavor.BETA;
      case FLAVOR_CANDIDATE:
        return LunaFlavor.CANDIDATE;
      case FLAVOR_STABLE:
        return LunaFlavor.STABLE;
    }
    throw Exception('Invalid LunaFlavor');
  }

  static LunaFlavor get current => LunaFlavor.fromKey(LunaEnvironment.flavor);
  static bool get isStable => current == LunaFlavor.STABLE;
}

extension LunaFlavorExtension on LunaFlavor {
  // Returns true if the running build's flavor is "lower" than or equal to the called-on flavor.
  /// For example, a running build of `beta` is lower than `candidate` but is not lower than `edge`.
  bool isRunningFlavor() {
    LunaFlavor flavor = LunaFlavor.current;
    if (flavor == this) return true;

    switch (this) {
      case LunaFlavor.EDGE:
        return false;
      case LunaFlavor.BETA:
        return flavor == LunaFlavor.EDGE;
      case LunaFlavor.CANDIDATE:
        return flavor == LunaFlavor.EDGE || flavor == LunaFlavor.BETA;
      case LunaFlavor.STABLE:
        return true;
    }
  }

  String get downloadLink {
    String base = 'https://builds.lunasea.app/#latest';
    switch (this) {
      case LunaFlavor.EDGE:
        return '$base/${this.key}/';
      case LunaFlavor.BETA:
        return '$base/${this.key}/';
      case LunaFlavor.CANDIDATE:
        return '$base/${this.key}/';
      case LunaFlavor.STABLE:
        return '$base/${this.key}/';
    }
  }

  String get name {
    switch (this) {
      case LunaFlavor.EDGE:
        return 'lunasea.Edge'.tr();
      case LunaFlavor.BETA:
        return 'lunasea.Beta'.tr();
      case LunaFlavor.CANDIDATE:
        return 'lunasea.Candidate'.tr();
      case LunaFlavor.STABLE:
        return 'lunasea.Stable'.tr();
    }
  }

  Color get color {
    switch (this) {
      case LunaFlavor.EDGE:
        return LunaColours.red;
      case LunaFlavor.BETA:
        return LunaColours.orange;
      case LunaFlavor.CANDIDATE:
        return LunaColours.blue;
      case LunaFlavor.STABLE:
        return LunaColours.accent;
    }
  }
}
