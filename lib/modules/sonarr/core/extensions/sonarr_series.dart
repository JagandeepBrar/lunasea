import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

extension SonarrSeriesExtension on SonarrSeries {
    int get lunaPercentageComplete {
        int _total = this.episodeCount ?? 0;
        int _available = this.episodeFileCount ?? 0;
        return _total == 0 ? 0 : ((_available/_total)*100).round();
    }

    String get lunaRuntime {
        if(this.runtime == null) return 'Unknown';
        return this.runtime == 1 ? '1 Minute' : '${this.runtime} Minutes';
    }

    String get lunaNextAiring {
        if(this.nextAiring == null) return 'Series Ended';
        return DateTime.parse(this.nextAiring).lsDateTime_date;
    }

    String get lunaAirTime {
        if(this.airTime == null) return 'Unknown Time';
        return this.airTime;
    }
}
