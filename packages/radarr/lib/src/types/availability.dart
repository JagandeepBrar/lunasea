part of radarr_types;

/// Enumerator to handle all availability options used in Radarr.
enum RadarrAvailability {
    ANNOUNCED,
    IN_CINEMAS,
    RELEASED,
    PREDB,
    TBA,
}

/// Extension on [RadarrAvailability] to implement extended functionality.
extension RadarrAvailabilityExtension on RadarrAvailability {
    /// Given a String, will return the correct [RadarrAvailability] object.
    RadarrAvailability? from(String? type) {
        switch(type) {
            case 'announced': return RadarrAvailability.ANNOUNCED;
            case 'inCinemas': return RadarrAvailability.IN_CINEMAS;
            case 'released': return RadarrAvailability.RELEASED;
            case 'preDB': return RadarrAvailability.PREDB;
            case 'tba': return RadarrAvailability.TBA;
            default: return null;
        }
    }

    String? get value {
        switch(this) {
            case RadarrAvailability.ANNOUNCED: return 'announced';
            case RadarrAvailability.IN_CINEMAS: return 'inCinemas';
            case RadarrAvailability.RELEASED: return 'released';
            case RadarrAvailability.PREDB: return 'preDB';
            case RadarrAvailability.TBA: return 'tba';
            default: return null;
        }
    }

    String? get readable {
        switch(this) {
            case RadarrAvailability.ANNOUNCED: return 'Announced';
            case RadarrAvailability.IN_CINEMAS: return 'In Cinemas';
            case RadarrAvailability.RELEASED: return 'Released';
            case RadarrAvailability.PREDB: return 'PreDB';
            case RadarrAvailability.TBA: return 'TBA';
            default: return null;
        }
    }
}
