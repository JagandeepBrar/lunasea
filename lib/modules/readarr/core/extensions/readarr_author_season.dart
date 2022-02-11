import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

extension ReadarrAuthorSeasonExtension on ReadarrAuthorSeason {
  String get lunaTitle {
    if (this.seasonNumber == 0) return 'readarr.Specials'.tr();
    return 'readarr.SeasonNumber'.tr(args: [
      this.seasonNumber?.toString() ?? 'lunasea.Unknown'.tr(),
    ]);
  }

  int get lunaPercentageComplete {
    int _total = this.statistics?.episodeCount ?? 0;
    int _available = this.statistics?.episodeFileCount ?? 0;
    return _total == 0 ? 0 : ((_available / _total) * 100).round();
  }

  String get lunaEpisodesAvailable {
    return '${this.statistics?.episodeFileCount ?? 0}/${this.statistics?.episodeCount ?? 0}';
  }
}
