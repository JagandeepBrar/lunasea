import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

extension LunaReadarrProtocolExtension on ReadarrProtocol {
  Color lunaProtocolColor({
    ReadarrRelease? release,
  }) {
    if (this == ReadarrProtocol.USENET) return LunaColours.accent;
    if (release == null) return LunaColours.blue;

    int seeders = release.seeders ?? 0;
    if (seeders > 10) return LunaColours.blue;
    if (seeders > 0) return LunaColours.orange;
    return LunaColours.red;
  }

  String lunaReadable() {
    switch (this) {
      case ReadarrProtocol.USENET:
        return 'readarr.Usenet'.tr();
      case ReadarrProtocol.TORRENT:
        return 'readarr.Torrent'.tr();
    }
  }
}
