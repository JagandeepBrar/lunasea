part of readarr_types;

enum ReadarrAuthorMonitorType {
  ALL,
  FUTURE,
  MISSING,
  EXISTING,
  PILOT,
  FIRST_SEASON,
  LATEST_SEASON,
  NONE,
}

extension ReadarrAuthorMonitorTypeExtension on ReadarrAuthorMonitorType {
  ReadarrAuthorMonitorType? from(String? type) {
    switch (type) {
      case 'all':
        return ReadarrAuthorMonitorType.ALL;
      case 'future':
        return ReadarrAuthorMonitorType.FUTURE;
      case 'missing':
        return ReadarrAuthorMonitorType.MISSING;
      case 'existing':
        return ReadarrAuthorMonitorType.EXISTING;
      case 'pilot':
        return ReadarrAuthorMonitorType.PILOT;
      case 'firstSeason':
        return ReadarrAuthorMonitorType.FIRST_SEASON;
      case 'latestSeason':
        return ReadarrAuthorMonitorType.LATEST_SEASON;
      case 'none':
        return ReadarrAuthorMonitorType.NONE;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case ReadarrAuthorMonitorType.ALL:
        return 'all';
      case ReadarrAuthorMonitorType.FUTURE:
        return 'future';
      case ReadarrAuthorMonitorType.MISSING:
        return 'missing';
      case ReadarrAuthorMonitorType.EXISTING:
        return 'existing';
      case ReadarrAuthorMonitorType.PILOT:
        return 'pilot';
      case ReadarrAuthorMonitorType.FIRST_SEASON:
        return 'firstSeason';
      case ReadarrAuthorMonitorType.LATEST_SEASON:
        return 'latestSeason';
      case ReadarrAuthorMonitorType.NONE:
        return 'none';
      default:
        return null;
    }
  }
}
