import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:radarr/radarr.dart';

extension RadarrReleaseExtension on RadarrRelease {
    IconData get lunaTrailingIcon {
        if(this.approved) return Icons.download_rounded;
        return Icons.report_rounded;
    } 

    Color get lunaTrailingColor {
        if(this.approved) return Colors.white;
        return LunaColours.red;
    }

    String get lunaProtocol {
        if(this.protocol != null) return this.protocol == RadarrProtocol.TORRENT ? '${this.protocol.readable} (${this?.seeders ?? 0}/${this?.leechers ?? 0})' : this.protocol.readable;
        return LunaUI.TEXT_EMDASH;
    }

    Color get lunaProtocolColor {
        if(this.protocol == RadarrProtocol.USENET) return LunaColours.blue;
        return LunaColours.purple;
    }

    String get lunaIndexer {
        if(this.indexer != null && this.indexer.isNotEmpty) return this.indexer;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaAge {
        if(this.ageHours != null) return this.ageHours.lunaHoursToAge();
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaQuality {
        if(this.quality != null && this.quality.quality != null) return this.quality.quality.name;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaSize {
        if(this.size != null) return this.size.lunaBytesToString();
        return LunaUI.TEXT_EMDASH;
    }
}
