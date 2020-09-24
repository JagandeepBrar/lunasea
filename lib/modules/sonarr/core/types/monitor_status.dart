import 'package:lunasea/core.dart';
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
    
    void process(List<dynamic> data) {
        switch(this) {
            case SonarrMonitorStatus.ALL: _all(data); break;
            case SonarrMonitorStatus.MISSING: _missing(data); break;
            case SonarrMonitorStatus.EXISTING: _existing(data); break;
            case SonarrMonitorStatus.FIRST_SEASON: _firstSeason(data); break;
            case SonarrMonitorStatus.LAST_SEASON: _lastSeason(data); break;
            case SonarrMonitorStatus.NONE: _none(data); break;
            case SonarrMonitorStatus.FUTURE: _future(data); break;
        }
    }

    void _all(List<dynamic> data) => data.forEach((element) {
        if(element['seasonNumber'] != 0) element['monitored'] = true;
    });

    void _missing(List<dynamic> data) => _all(data);
    
    void _existing(List<dynamic> data) => _all(data);
    
    void _future(List<dynamic> data) => _lastSeason(data);
    
    void _firstSeason(List<dynamic> data) {
        _none(data);
        data[0]['seasonNumber'] == 0
            ? data[1]['monitored'] = true
            : data[0]['monitored'] = false;
    }

    void _lastSeason(List<dynamic> data) {
        _none(data);
        data[data.length-1]['monitored'] = true;
    }

    void _none(List<dynamic> data) => data.forEach((element) => element['monitored'] = false);
}
