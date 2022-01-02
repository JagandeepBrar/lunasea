import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

extension LunaSonarrProtocolExtension on SonarrProtocol {
  Color lunaProtocolColor({
    SonarrRelease? release,
  }) {
    if (this == SonarrProtocol.USENET) return LunaColours.accent;
    if (release == null) return LunaColours.blue;

    int seeders = release.seeders ?? 0;
    if (seeders > 10) return LunaColours.blue;
    if (seeders > 0) return LunaColours.orange;
    return LunaColours.red;
  }

  String lunaReadable() {
    switch (this) {
      case SonarrProtocol.USENET:
        return 'sonarr.Usenet'.tr();
      case SonarrProtocol.TORRENT:
        return 'sonarr.Torrent'.tr();
    }
  }
}
