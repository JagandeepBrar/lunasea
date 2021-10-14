part of sonarr_types;

enum SonarrHistorySortKey {
    DATE,
    SERIES_TITLE,
}

/// Extension on [SonarrHistorySortKey] to implement extended functionality.
extension SonarrHistorySortKeyExtension on SonarrHistorySortKey {
    /// Given a String, will return the correct `SonarrHistorySortKey` object.
    SonarrHistorySortKey? from(String? type) {
        switch(type) {
            case 'date': return SonarrHistorySortKey.DATE;
            case 'series.title': return SonarrHistorySortKey.SERIES_TITLE;
            default: return null;
        }
    }

    /// The actual value/key for sorting directions used in Sonarr.
    String? get value {
        switch(this) {
            case SonarrHistorySortKey.DATE: return 'date';
            case SonarrHistorySortKey.SERIES_TITLE: return 'series.title';
            default: return null;
        }
    }
}
