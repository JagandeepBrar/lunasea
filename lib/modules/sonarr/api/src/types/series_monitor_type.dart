part of sonarr_types;

enum SonarrSeriesMonitorType {
  ALL,
  FUTURE,
  MISSING,
  EXISTING,
  PILOT,
  FIRST_SEASON,
  LATEST_SEASON,
  NONE,
}

extension SonarrSeriesMonitorTypeExtension on SonarrSeriesMonitorType {
  SonarrSeriesMonitorType? from(String? type) {
    switch (type) {
      case 'all':
        return SonarrSeriesMonitorType.ALL;
      case 'future':
        return SonarrSeriesMonitorType.FUTURE;
      case 'missing':
        return SonarrSeriesMonitorType.MISSING;
      case 'existing':
        return SonarrSeriesMonitorType.EXISTING;
      case 'pilot':
        return SonarrSeriesMonitorType.PILOT;
      case 'firstSeason':
        return SonarrSeriesMonitorType.FIRST_SEASON;
      case 'latestSeason':
        return SonarrSeriesMonitorType.LATEST_SEASON;
      case 'none':
        return SonarrSeriesMonitorType.NONE;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case SonarrSeriesMonitorType.ALL:
        return 'all';
      case SonarrSeriesMonitorType.FUTURE:
        return 'future';
      case SonarrSeriesMonitorType.MISSING:
        return 'missing';
      case SonarrSeriesMonitorType.EXISTING:
        return 'existing';
      case SonarrSeriesMonitorType.PILOT:
        return 'pilot';
      case SonarrSeriesMonitorType.FIRST_SEASON:
        return 'firstSeason';
      case SonarrSeriesMonitorType.LATEST_SEASON:
        return 'latestSeason';
      case SonarrSeriesMonitorType.NONE:
        return 'none';
      default:
        return null;
    }
  }
}
