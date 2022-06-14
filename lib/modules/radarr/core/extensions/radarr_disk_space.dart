import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrDiskSpaceExtension on RadarrDiskSpace {
  String? get lunaPath {
    if (this.path != null && this.path!.isNotEmpty) return this.path;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaSpace {
    String numerator = this.freeSpace.asBytes();
    String denumerator = this.totalSpace.asBytes();
    return '$numerator / $denumerator\n';
  }

  int get lunaPercentage {
    int? _percentNumerator = this.freeSpace;
    int? _percentDenominator = this.totalSpace;
    if (_percentNumerator != null &&
        _percentDenominator != null &&
        _percentDenominator != 0) {
      int _val = ((_percentNumerator / _percentDenominator) * 100).round();
      return (_val - 100).abs();
    }
    return 0;
  }

  String get lunaPercentageString => '$lunaPercentage%';

  Color get lunaColor {
    int percentage = this.lunaPercentage;
    if (percentage >= 90) return LunaColours.red;
    if (percentage >= 80) return LunaColours.orange;
    return LunaColours.accent;
  }
}
