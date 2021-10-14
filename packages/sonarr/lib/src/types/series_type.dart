part of sonarr_types;

enum SonarrSeriesType {
  STANDARD,
  DAILY,
  ANIME,
}

extension SonarrSeriesTypeExtension on SonarrSeriesType {
  SonarrSeriesType? from(String? type) {
    switch (type) {
      case 'standard':
        return SonarrSeriesType.STANDARD;
      case 'daily':
        return SonarrSeriesType.DAILY;
      case 'anime':
        return SonarrSeriesType.ANIME;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case SonarrSeriesType.STANDARD:
        return 'standard';
      case SonarrSeriesType.DAILY:
        return 'daily';
      case SonarrSeriesType.ANIME:
        return 'anime';
      default:
        return null;
    }
  }
}
