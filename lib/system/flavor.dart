import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';

const _EDGE = 'edge';
const _BETA = 'beta';
const _CANDIDATE = 'candidate';
const _STABLE = 'stable';

enum LunaFlavor {
  EDGE,
  BETA,
  CANDIDATE,
  STABLE,
}

extension LunaFlavorExtension on LunaFlavor {
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
