part of sonarr_types;

enum SonarrSortDirection {
    ASCENDING,
    DESCENDING,
}

/// Extension on [SonarrSortDirection] to implement extended functionality.
extension SonarrSortDirectionExtension on SonarrSortDirection {
    /// The actual value/key for sorting directions used in Sonarr.
    String? get value {
        switch(this) {
            case SonarrSortDirection.ASCENDING: return 'asc';
            case SonarrSortDirection.DESCENDING: return 'desc';
            default: return null;
        }
    }
}
