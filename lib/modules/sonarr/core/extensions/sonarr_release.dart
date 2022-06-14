import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/double/time.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/modules/sonarr.dart';

extension SonarrReleaseExtension on SonarrRelease {
  IconData get lunaTrailingIcon {
    if (this.approved!) return Icons.download_rounded;
    return Icons.report_outlined;
  }

  Color get lunaTrailingColor {
    if (this.approved!) return Colors.white;
    return LunaColours.red;
  }

  String get lunaProtocol {
    if (this.protocol != null) {
      return this.protocol == SonarrProtocol.TORRENT
          ? '${this.protocol!.lunaReadable()} (${this.seeders ?? 0}/${this.leechers ?? 0})'
          : this.protocol!.lunaReadable();
    }
    return LunaUI.TEXT_EMDASH;
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

  String? get lunaLanguage {
    if (this.language != null && this.language != null)
      return this.language!.name;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaSize {
    if (this.size != null) return this.size.asBytes();
    return LunaUI.TEXT_EMDASH;
  }

  String? lunaPreferredWordScore({bool nullOnEmpty = false}) {
    if ((this.preferredWordScore ?? 0) != 0) {
      String _prefix = this.preferredWordScore! > 0 ? '+' : '';
      return '$_prefix${this.preferredWordScore}';
    }
    if (nullOnEmpty) return null;
    return LunaUI.TEXT_EMDASH;
  }
}
