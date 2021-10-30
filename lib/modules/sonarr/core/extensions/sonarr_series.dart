import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

extension SonarrSeriesExtension on SonarrSeries {
  int get lunaPercentageComplete {
    int _total = this.statistics?.episodeCount ?? 0;
    int _available = this.statistics?.episodeFileCount ?? 0;
    return _total == 0 ? 0 : ((_available / _total) * 100).round();
  }

  String get lunaRuntime {
    if (this.runtime == null) {
      return 'Unknown';
    }
    return this.runtime == 1 ? '1 Minute' : '${this.runtime} Minutes';
  }

  String get lunaNextAiring {
    if (this.nextAiring == null) {
      return LunaUI.TEXT_EMDASH;
    }
    return DateFormat('MMMM dd, y').format(this.nextAiring.toLocal());
  }

  String get lunaDateAdded {
    if (this.added == null) {
      return 'Unknown';
    }
    return DateFormat('MMMM dd, y').format(this.added.toLocal());
  }

  String get lunaAirTime {
    if (this.previousAiring != null) {
      return LunaDatabaseValue.USE_24_HOUR_TIME.data
          ? DateFormat.Hm().format(this.previousAiring.toLocal())
          : DateFormat('hh:mm a').format(this.previousAiring.toLocal());
    }
    if (this.airTime == null) {
      return 'Unknown';
    }
    return this.airTime;
  }

  String get lunaSeriesType {
    if (this.seriesType == null) {
      return 'Unknown';
    }
    return this.seriesType.value.lunaCapitalizeFirstLetters();
  }

  String get lunaSeasonCount {
    if (this.statistics?.seasonCount == null) {
      return 'Unknown';
    }
    return this.statistics.seasonCount == 1
        ? '1 Season'
        : '${this.statistics.seasonCount} Seasons';
  }

  String get lunaSizeOnDisk {
    if (this.statistics?.sizeOnDisk == null) {
      return '0.0 B';
    }
    return this.statistics.sizeOnDisk.lunaBytesToString(decimals: 1);
  }

  String get lunaAirsOn {
    if (this.status == 'ended') {
      return 'Aired on ${this.network ?? LunaUI.TEXT_EMDASH}';
    }
    return '${this.lunaAirTime ?? 'Unknown Time'} on ${this.network ?? LunaUI.TEXT_EMDASH}';
  }

  String get lunaEpisodeCount {
    int episodeFileCount = this.statistics?.episodeFileCount ?? 0;
    int episodeCount = this.statistics?.episodeCount ?? 0;
    int percentage = this.lunaPercentageComplete;
    return '$episodeFileCount/$episodeCount ($percentage%)';
  }

  /// Creates a clone of the [SonarrSeries] object (deep copy).
  SonarrSeries clone() => SonarrSeries.fromJson(this.toJson());

  /// Copies changes from a [SonarrSeriesEditState] state object back to the [SonarrSeries] object.
  SonarrSeries updateEdits(SonarrSeriesEditState edits) {
    SonarrSeries series = this.clone();
    series.monitored = edits?.monitored ?? this.monitored;
    series.seasonFolder = edits?.useSeasonFolders ?? this.seasonFolder;
    series.path = edits?.seriesPath ?? this.path;
    series.qualityProfileId =
        edits?.qualityProfile?.id ?? this.qualityProfileId;
    series.languageProfileId =
        edits?.languageProfile?.id ?? this.languageProfileId;
    series.seriesType = edits?.seriesType ?? this.seriesType;
    series.tags = edits?.tags?.map((tag) => tag.id)?.toList() ?? [];
    return series;
  }
}
