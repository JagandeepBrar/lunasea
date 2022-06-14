import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/double/time.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/modules/radarr.dart';

extension RadarrReleaseExtension on RadarrRelease {
  IconData get lunaTrailingIcon {
    if (this.approved!) return Icons.download_rounded;
    return Icons.report_outlined;
  }

  Color get lunaTrailingColor {
    if (this.approved!) return Colors.white;
    return LunaColours.red;
  }

  String? get lunaProtocol {
    if (this.protocol != null)
      return this.protocol == RadarrProtocol.TORRENT
          ? '${this.protocol!.readable} (${this.seeders ?? 0}/${this.leechers ?? 0})'
          : this.protocol!.readable;
    return LunaUI.TEXT_EMDASH;
  }

  Color get lunaProtocolColor {
    if (this.protocol == RadarrProtocol.USENET) return LunaColours.accent;
    int seeders = this.seeders ?? 0;
    if (seeders > 10) return LunaColours.blue;
    if (seeders > 0) return LunaColours.orange;
    return LunaColours.red;
  }

  String? get lunaIndexer {
    if (this.indexer != null && this.indexer!.isNotEmpty) return this.indexer;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaAge {
    if (this.ageHours != null) return this.ageHours!.asTimeAgo();
    return LunaUI.TEXT_EMDASH;
  }

  String? get lunaQuality {
    if (this.quality != null && this.quality!.quality != null)
      return this.quality!.quality!.name;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaSize {
    if (this.size != null) return this.size.asBytes();
    return LunaUI.TEXT_EMDASH;
  }

  String? lunaCustomFormatScore({bool nullOnEmpty = false}) {
    if ((this.customFormatScore ?? 0) != 0) {
      String _prefix = this.customFormatScore! > 0 ? '+' : '';
      return '$_prefix${this.customFormatScore}';
    }
    if (nullOnEmpty) return null;
    return LunaUI.TEXT_EMDASH;
  }
}
