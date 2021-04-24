import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

extension SonarrReleaseExtension on SonarrRelease {
  Color get lunaProtocolColor {
    if ((this.protocol?.toLowerCase() ?? '') == 'usenet')
      return LunaColours.accent;
    int seeders = this.seeders ?? 0;
    if (seeders > 10) return LunaColours.blue;
    if (seeders > 0) return LunaColours.orange;
    return LunaColours.red;
  }
}
