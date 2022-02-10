import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

extension ReadarrBookExtension on ReadarrBook {
  /// Creates a clone of the [ReadarrBook] object (deep copy).
  ReadarrBook clone() => ReadarrBook.fromJson(this.toJson());

  String get lunaGenres {
    if (this.genres?.isNotEmpty ?? false) return this.genres!.join('\n');
    return LunaUI.TEXT_EMDASH;
  }

  String lunaReleaseDate() {
    if (this.releaseDate == null) return 'lunasea.UnknownDate'.tr();
    return DateFormat.yMMMMd().format(this.releaseDate!.toLocal());
  }

  String lunaDownloadedQuality(
    ReadarrBookFile? file,
    ReadarrQueueRecord? queueRecord,
  ) {
    if (queueRecord != null) {
      return [
        queueRecord.lunaPercentage(),
        LunaUI.TEXT_EMDASH,
        queueRecord.lunaStatusParameters().item1,
      ].join(' ');
    }

/*
    if (!this.hasFile!) {
      if (_hasAired()) return 'readarr.Unaired'.tr();
      return 'readarr.Missing'.tr();
    }
    if (file == null) return 'lunasea.Unknown'.tr();
    String quality = file.quality?.quality?.name ?? 'lunasea.Unknown'.tr();
    String size = file.size?.lunaBytesToString() ?? '0.00 B';
    return '$quality ${LunaUI.TEXT_EMDASH} $size';
    */

    return "unknown";
  }

  Color lunaDownloadedQualityColor(
    ReadarrBookFile? file,
    ReadarrQueueRecord? queueRecord,
  ) {
    if (queueRecord != null) {
      return queueRecord.lunaStatusParameters(canBeWhite: false).item3;
    }

    return LunaColours.blueGrey;
/*
    if (!this.hasFile!) {
      if (_hasAired()) return LunaColours.blue;
      return LunaColours.red;
    }
    if (file == null) return LunaColours.blueGrey;
    if (file.qualityCutoffNotMet!) return LunaColours.orange;
    return LunaColours.accent;*/
  }
}
