import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

extension ReadarrAuthorExtension on ReadarrAuthor {
  String get lunaGenres {
    if (this.genres?.isNotEmpty ?? false) return this.genres!.join('\n');
    return LunaUI.TEXT_EMDASH;
  }

  String lunaTags(List<ReadarrTag> tags) {
    if (tags.isNotEmpty) return tags.map<String>((t) => t.label!).join('\n');
    return LunaUI.TEXT_EMDASH;
  }

  int get lunaPercentageComplete {
    int _total = this.statistics?.episodeCount ?? 0;
    int _available = this.statistics?.episodeFileCount ?? 0;
    return _total == 0 ? 0 : ((_available / _total) * 100).round();
  }

  String get lunaDateAdded {
    if (this.added == null) {
      return 'lunasea.Unknown'.tr();
    }
    return DateFormat('MMMM dd, y').format(this.added!.toLocal());
  }

  String get lunaDateAddedShort {
    if (this.added == null) {
      return 'lunasea.Unknown'.tr();
    }
    return DateFormat('MMM dd, y').format(this.added!.toLocal());
  }

  String get lunaSizeOnDisk {
    if (this.statistics?.sizeOnDisk == null) {
      return '0.0 B';
    }
    return this.statistics!.sizeOnDisk.lunaBytesToString(decimals: 1);
  }

  String? get lunaOverview {
    if (this.overview == null || this.overview!.isEmpty) {
      return 'readarr.NoSummaryAvailable'.tr();
    }
    return this.overview;
  }

  String get lunaEpisodeCount {
    int episodeFileCount = this.statistics?.episodeFileCount ?? 0;
    int episodeCount = this.statistics?.episodeCount ?? 0;
    int percentage = this.lunaPercentageComplete;
    return '$episodeFileCount/$episodeCount ($percentage%)';
  }

  /// Creates a clone of the [ReadarrAuthor] object (deep copy).
  ReadarrAuthor clone() => ReadarrAuthor.fromJson(this.toJson());

  /// Copies changes from a [ReadarrAuthorEditState] state object back to the [ReadarrAuthor] object.
  ReadarrAuthor updateEdits(ReadarrAuthorEditState edits) {
    ReadarrAuthor series = this.clone();
    series.monitored = edits.monitored;
    series.path = edits.seriesPath;
    series.qualityProfileId = edits.qualityProfile?.id ?? this.qualityProfileId;
    series.metadataProfileId =
        edits.metadataProfile.id ?? this.metadataProfileId;
    series.tags = edits.tags?.map((t) => t.id!).toList() ?? [];
    return series;
  }
}
