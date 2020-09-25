import 'package:intl/intl.dart';
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
        if(this.nextAiring == null) return Constants.TEXT_EMDASH;
        return DateFormat('MMMM dd, y').format(this.nextAiring.toLocal());
    }

    String get lunaDateAdded {
        if(this.added == null) return 'Unknown';
        return DateFormat('MMMM dd, y').format(this.added.toLocal());
    }

    String get lunaAirTime {
        if(this.previousAiring != null) return LunaSeaDatabaseValue.USE_24_HOUR_TIME.data
            ? DateFormat.Hm().format(this.previousAiring.toLocal())
            : DateFormat('hh:mm a').format(this.previousAiring.toLocal());
        if(this.airTime == null) return 'Unknown';
        return this.airTime;
    }

    String get lunaSeriesType {
        if(this.seriesType == null) return 'Unknown';
        return this.seriesType.value.lsLanguage_Capitalize();
    }

    String get lunaSeasonCount {
        if(this.seasonCount == null) return 'Unknown';
        return this.seasonCount == 1
            ? '1 Season'
            : '${this.seasonCount} Seasons';
    }

    String get lunaSizeOnDisk {
        if(this.sizeOnDisk == null) return '0.0 B';
        return this.sizeOnDisk.lsBytes_BytesToString(decimals: 1);
    }

    String get lunaAirsOn {
        if(this.status == 'ended') return 'Aired on ${this.network ?? 'Unknown Network'}';
        return '${this.lunaAirTime ?? 'Unknown Time'} on ${this.network ?? 'Unknown Network'}';
    }

    String get lunaEpisodeCount {
        return '${this.episodeFileCount ?? 0}/${this.episodeCount ?? 0} (${this.lunaPercentageComplete}%)';
    }
}
