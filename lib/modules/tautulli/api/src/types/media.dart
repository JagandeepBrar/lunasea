part of tautulli_types;

/// Enumerator to handle all media types used in Tautulli.
enum TautulliMediaType {
    MOVIE,
    SHOW,
    SEASON,
    EPISODE,
    ARTIST,
    ALBUM,
    TRACK,
    LIVE,
    COLLECTION,
    NULL,
}

/// Extension on [TautulliMediaType] to implement extended functionality.
extension TautulliMediaTypeExtension on TautulliMediaType? {
    /// Given a String, will return the correct `TautulliMediaType` object.
    TautulliMediaType? from(String? type) {
        switch(type) {
            case 'movie': return TautulliMediaType.MOVIE;
            case 'show': return TautulliMediaType.SHOW;
            case 'season': return TautulliMediaType.SEASON;
            case 'episode': return TautulliMediaType.EPISODE;
            case 'artist': return TautulliMediaType.ARTIST;
            case 'album': return TautulliMediaType.ALBUM;
            case 'track': return TautulliMediaType.TRACK;
            case 'live': return TautulliMediaType.LIVE;
            case 'collection': return TautulliMediaType.COLLECTION;
            case '': return TautulliMediaType.NULL;
        }
        return null;
    }

    /// The actual value/key for media types used in Tautulli.
    String? get value {
        switch(this) {
            case TautulliMediaType.MOVIE: return 'movie';
            case TautulliMediaType.SHOW: return 'show';
            case TautulliMediaType.SEASON: return 'season';
            case TautulliMediaType.EPISODE: return 'episode';
            case TautulliMediaType.ARTIST: return 'artist';
            case TautulliMediaType.ALBUM: return 'album';
            case TautulliMediaType.TRACK: return 'track';
            case TautulliMediaType.LIVE: return 'live';
            case TautulliMediaType.COLLECTION: return 'collection';
            case TautulliMediaType.NULL: return '';
            default: return null;
        }
    }
}
