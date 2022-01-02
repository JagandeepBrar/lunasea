part of sonarr_types;

enum SonarrWantedMissingSortKey {
    AIRDATE_UTC,
    SERIES_TITLE,
}

/// Extension on [SonarrWantedMissingSortKey] to implement extended functionality.
extension SonarrWantedMissingSortKeyExtension on SonarrWantedMissingSortKey {
    /// Given a String, will return the correct `SonarrWantedMissingSortKey` object.
    SonarrWantedMissingSortKey? from(String? type) {
        switch(type) {
            case 'airDateUtc': return SonarrWantedMissingSortKey.AIRDATE_UTC;
            case 'series.title': return SonarrWantedMissingSortKey.SERIES_TITLE;
            default: return null;
        }
    }

    /// The actual value/key for sorting directions used in Sonarr.
    String? get value {
        switch(this) {
            case SonarrWantedMissingSortKey.AIRDATE_UTC: return 'airDateUtc';
            case SonarrWantedMissingSortKey.SERIES_TITLE: return 'series.title';
            default: return null;
        }
    }
}
