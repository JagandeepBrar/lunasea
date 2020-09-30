import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
part 'monitor_status.g.dart';

@HiveType(typeId: 14, adapterName: 'SonarrMonitorStatusAdapter')
enum SonarrMonitorStatus {
    @HiveField(0)
    ALL,
    @HiveField(1)
    FUTURE,
    @HiveField(2)
    MISSING,
    @HiveField(3)
    EXISTING,
    @HiveField(4)
    FIRST_SEASON,
    @HiveField(5)
    LAST_SEASON,
    @HiveField(6)
    NONE,
}

extension SonarrMonitorStatusExtension on SonarrMonitorStatus {
    String get name {
        switch(this) {
            case SonarrMonitorStatus.ALL: return 'All';
            case SonarrMonitorStatus.MISSING: return 'Missing';
            case SonarrMonitorStatus.EXISTING: return 'Existing';
            case SonarrMonitorStatus.FIRST_SEASON: return 'First Season';
            case SonarrMonitorStatus.LAST_SEASON: return 'Last Season';
            case SonarrMonitorStatus.NONE: return 'None';
            case SonarrMonitorStatus.FUTURE: return 'Future';
        }
        throw Exception('unknown name');
    }
    
    void process(SonarrSeriesLookup series) {
        switch(this) {
            case SonarrMonitorStatus.ALL: _all(series); break;
            case SonarrMonitorStatus.MISSING: _missing(series); break;
            case SonarrMonitorStatus.EXISTING: _existing(series); break;
            case SonarrMonitorStatus.FIRST_SEASON: _firstSeason(series); break;
            case SonarrMonitorStatus.LAST_SEASON: _lastSeason(series); break;
            case SonarrMonitorStatus.NONE: _none(series); break;
            case SonarrMonitorStatus.FUTURE: _future(series); break;
        }
    }

    void _all(SonarrSeriesLookup data) => data.seasons.forEach((season) {
        if(season.seasonNumber != 0) season.monitored = true;
    });

    void _missing(SonarrSeriesLookup data) => _all(data);
    
    void _existing(SonarrSeriesLookup data) => _all(data);
    
    void _future(SonarrSeriesLookup data) => _lastSeason(data);
    
    void _firstSeason(SonarrSeriesLookup data) {
        _none(data);
        data.seasons[0].seasonNumber == 0
            ? data.seasons[1].monitored = true
            : data.seasons[0].monitored = true;
    }

    void _lastSeason(SonarrSeriesLookup data) {
        _none(data);
        data.seasons[data.seasons.length-1].monitored = true;
    }

    void _none(SonarrSeriesLookup data) => data.seasons.forEach((season) => season.monitored = false);
}
