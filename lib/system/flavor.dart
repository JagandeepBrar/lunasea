import 'package:flutter/material.dart';
import 'package:lunasea/system/environment.dart';
import 'package:lunasea/widgets/ui.dart';

const _EDGE = 'edge';
const _BETA = 'beta';
const _CANDIDATE = 'candidate';
const _STABLE = 'stable';

enum LunaFlavor {
  EDGE,
  BETA,
  CANDIDATE,
  STABLE;

  static LunaFlavor get current => LunaFlavor.EDGE.from(LunaEnvironment.flavor);
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

  String get key {
    switch (this) {
      case LunaFlavor.EDGE:
        return _EDGE;
      case LunaFlavor.BETA:
        return _BETA;
      case LunaFlavor.CANDIDATE:
        return _CANDIDATE;
      case LunaFlavor.STABLE:
        return _STABLE;
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

  LunaFlavor from(String key) {
    switch (key) {
      case _EDGE:
        return LunaFlavor.EDGE;
      case _BETA:
        return LunaFlavor.BETA;
      case _CANDIDATE:
        return LunaFlavor.CANDIDATE;
      case _STABLE:
        return LunaFlavor.STABLE;
    }
    throw Exception('Invalid LunaFlavor');
  }
}
