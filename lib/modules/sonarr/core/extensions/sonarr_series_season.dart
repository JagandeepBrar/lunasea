import 'package:lunasea/modules/sonarr.dart';

extension SonarrSeriesSeasonExtension on SonarrSeriesSeason {
    int get lunaPercentageComplete {
        int _total = this?.statistics?.totalEpisodeCount ?? 0;
        int _available = this?.statistics?.episodeFileCount ?? 0;
        return _total == 0 ? 0 : ((_available/_total)*100).round();
    }
}
