import 'package:lunasea/core.dart';
part 'monitor_status.g.dart';

@HiveType(typeId: 14, adapterName: 'DeprecatedSonarrMonitorStatusAdapter')
enum DeprecatedSonarrMonitorStatus {
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

extension DeprecatedSonarrMonitorStatusExtension on DeprecatedSonarrMonitorStatus {
    String get name {
        switch(this) {
            case DeprecatedSonarrMonitorStatus.ALL: return 'All';
            case DeprecatedSonarrMonitorStatus.MISSING: return 'Missing';
            case DeprecatedSonarrMonitorStatus.EXISTING: return 'Existing';
            case DeprecatedSonarrMonitorStatus.FIRST_SEASON: return 'First Season';
            case DeprecatedSonarrMonitorStatus.LAST_SEASON: return 'Last Season';
            case DeprecatedSonarrMonitorStatus.NONE: return 'None';
            case DeprecatedSonarrMonitorStatus.FUTURE: return 'Future';
        }
        throw Exception('unknown name');
    }
    
    void process(List<dynamic> data) {
        switch(this) {
            case DeprecatedSonarrMonitorStatus.ALL: _all(data); break;
            case DeprecatedSonarrMonitorStatus.MISSING: _missing(data); break;
            case DeprecatedSonarrMonitorStatus.EXISTING: _existing(data); break;
            case DeprecatedSonarrMonitorStatus.FIRST_SEASON: _firstSeason(data); break;
            case DeprecatedSonarrMonitorStatus.LAST_SEASON: _lastSeason(data); break;
            case DeprecatedSonarrMonitorStatus.NONE: _none(data); break;
            case DeprecatedSonarrMonitorStatus.FUTURE: _future(data); break;
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
