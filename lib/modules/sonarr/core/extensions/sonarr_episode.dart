import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

extension SonarrEpisodeExtension on SonarrEpisode {
  bool _hasAired() {
    return this?.airDateUtc?.toLocal()?.isAfter(DateTime.now()) ?? true;
  }

  /// Creates a clone of the [SonarrEpisode] object (deep copy).
  SonarrEpisode clone() => SonarrEpisode.fromJson(this.toJson());

  String lunaAirDate() {
    if (this.airDateUtc == null) return 'lunasea.UnknownDate'.tr();
    return DateFormat.yMMMMd().format(this.airDateUtc.toLocal());
  }

  String lunaDownloadedQuality(SonarrEpisodeFile file) {
    if (!this.hasFile) {
      if (_hasAired()) return 'sonarr.Unaired'.tr();
      return 'sonarr.Missing'.tr();
    }
    if (file == null) return 'sonarr.Unknown'.tr();
    String quality = file?.quality?.quality?.name ?? 'lunasea.Unknown'.tr();
    String size = file?.size?.lunaBytesToString();
    return '$quality ${LunaUI.TEXT_EMDASH} $size';
  }

  Color lunaDownloadedQualityColor(SonarrEpisodeFile file) {
    if (!this.hasFile) {
      if (_hasAired()) return LunaColours.blue;
      return LunaColours.red;
    }
    if (file == null) return LunaColours.blueGrey;
    if (file.qualityCutoffNotMet) return LunaColours.orange;
    return LunaColours.accent;
  }
}
