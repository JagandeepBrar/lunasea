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
    switch (this) {
      case SonarrMonitorStatus.ALL:
        return 'All';
      case SonarrMonitorStatus.MISSING:
        return 'Missing';
      case SonarrMonitorStatus.EXISTING:
        return 'Existing';
      case SonarrMonitorStatus.FIRST_SEASON:
        return 'First Season';
      case SonarrMonitorStatus.LAST_SEASON:
        return 'Last Season';
      case SonarrMonitorStatus.NONE:
        return 'None';
      case SonarrMonitorStatus.FUTURE:
        return 'Future';
    }
  }

  String? get key {
    switch (this) {
      case SonarrMonitorStatus.ALL:
        return 'all';
      case SonarrMonitorStatus.FUTURE:
        return 'future';
      case SonarrMonitorStatus.MISSING:
        return 'missing';
      case SonarrMonitorStatus.EXISTING:
        return 'existing';
      case SonarrMonitorStatus.FIRST_SEASON:
        return 'firstseason';
      case SonarrMonitorStatus.LAST_SEASON:
        return 'lastseason';
      case SonarrMonitorStatus.NONE:
        return 'none';
      default:
        return null;
    }
  }

  SonarrMonitorStatus? fromKey(String key) {
    switch (key) {
      case 'all':
        return SonarrMonitorStatus.ALL;
      case 'future':
        return SonarrMonitorStatus.FUTURE;
      case 'missing':
        return SonarrMonitorStatus.MISSING;
      case 'existing':
        return SonarrMonitorStatus.EXISTING;
      case 'firstseason':
        return SonarrMonitorStatus.FIRST_SEASON;
      case 'lastseason':
        return SonarrMonitorStatus.LAST_SEASON;
      case 'none':
        return SonarrMonitorStatus.NONE;
      default:
        return null;
    }
  }

  void process(List<SonarrSeriesSeason> season) {
    if (season.isEmpty) return;
    switch (this) {
      case SonarrMonitorStatus.ALL:
        _all(season);
        break;
      case SonarrMonitorStatus.MISSING:
        _missing(season);
        break;
      case SonarrMonitorStatus.EXISTING:
        _existing(season);
        break;
      case SonarrMonitorStatus.FIRST_SEASON:
        _firstSeason(season);
        break;
      case SonarrMonitorStatus.LAST_SEASON:
        _lastSeason(season);
        break;
      case SonarrMonitorStatus.NONE:
        _none(season);
        break;
      case SonarrMonitorStatus.FUTURE:
        _future(season);
        break;
    }
  }

  void _all(List<SonarrSeriesSeason> data) => data.forEach((season) {
        if (season.seasonNumber != 0) season.monitored = true;
      });

  void _missing(List<SonarrSeriesSeason> data) => _all(data);

  void _existing(List<SonarrSeriesSeason> data) => _all(data);

  void _future(List<SonarrSeriesSeason> data) => _lastSeason(data);

  void _firstSeason(List<SonarrSeriesSeason> data) {
    _none(data);
    data[0].seasonNumber == 0
        ? data[1].monitored = true
        : data[0].monitored = true;
  }

  void _lastSeason(List<SonarrSeriesSeason> data) {
    _none(data);
    data[data.length - 1].monitored = true;
  }

  void _none(List<SonarrSeriesSeason> data) =>
      data.forEach((season) => season.monitored = false);
}
