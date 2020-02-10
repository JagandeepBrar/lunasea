import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

abstract class SonarrHistoryEntry {
    String seriesTitle;
    String episodeTitle;
    String timestamp;
    String eventType;
    int seriesID;
    int episodeNumber;
    int seasonNumber;

    SonarrHistoryEntry(
        this.seriesID,
        this.seriesTitle,
        this.episodeTitle,
        this.episodeNumber,
        this.seasonNumber,
        this.timestamp,
        this.eventType,
    );

    DateTime get timestampObject {
        return DateTime.tryParse(timestamp)?.toLocal();
    }

    String get timestampString {
        if(timestampObject != null) {
            Duration age = DateTime.now().difference(timestampObject);
            if(age.inDays >= 1) {
                return age.inDays == 1 ? '${age.inDays} Day Ago' : '${age.inDays} Days Ago';
            }
            if(age.inHours >= 1) {
                return age.inHours == 1 ? '${age.inHours} Hour Ago' : '${age.inHours} Hours Ago';
            }
            return age.inMinutes == 1 ? '${age.inMinutes} Minute Ago' : '${age.inMinutes} Minutes Ago';
        }
        return 'Unknown Date/Time';
    }

    String posterURI({bool highRes = false}) {
        List<dynamic> values = Values.sonarrValues;
        if(highRes) {
            return '${values[1]}/api/mediacover/$seriesID/poster.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/mediacover/$seriesID/poster-500.jpg?apikey=${values[2]}';
    }

    String fanartURI({bool highRes = false}) {
        List<dynamic> values = Values.sonarrValues;
        if(highRes) {
            return '${values[1]}/api/mediacover/$seriesID/fanart.jpg?apikey=${values[2]}'; 
        }
        return '${values[1]}/api/mediacover/$seriesID/fanart-360.jpg?apikey=${values[2]}'; 
    }

    String bannerURI({bool highRes = false}) {
        List<dynamic> values = Values.sonarrValues;
        if(highRes) {
            return '${values[1]}/api/mediacover/$seriesID/banner.jpg?apikey=${values[2]}';
        }
        return '${values[1]}/api/mediacover/$seriesID/banner-70.jpg?apikey=${values[2]}';
    }

    List<TextSpan> get subtitle;
}

class SonarrHistoryEntryGeneric extends SonarrHistoryEntry {
    String _eventType;

    SonarrHistoryEntryGeneric(
        int seriesID,
        String showTitle,
        String episodeTitle,
        int episodeNumber,
        int seasonNumber,
        String timestamp,
        this._eventType,
    ) : super(seriesID, showTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, _eventType);

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '$_eventType',
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class SonarrHistoryEntryEpisodeRenamed extends SonarrHistoryEntry {
    SonarrHistoryEntryEpisodeRenamed (
        int seriesID,
        String showTitle,
        String episodeTitle,
        int episodeNumber,
        int seasonNumber,
        String timestamp,
    ) : super(seriesID, showTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, 'episodeFileRenamed');

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.sonarrEventTypeMessages[eventType]}',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class SonarrHistoryEntryEpisodeDeleted extends SonarrHistoryEntry {
    String _reason;

    SonarrHistoryEntryEpisodeDeleted (
        int seriesID,
        String showTitle,
        String episodeTitle,
        int episodeNumber,
        int seasonNumber,
        String timestamp,
        this._reason,
    ) : super(seriesID, showTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, 'episodeFileDeleted');

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.sonarrEventTypeMessages[eventType]} (${Constants.historyReasonMessages[_reason] ?? _reason})',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class SonarrHistoryEntryDownloadImported extends SonarrHistoryEntry {
    String _quality;

    SonarrHistoryEntryDownloadImported (
        int seriesID,
        String showTitle,
        String episodeTitle,
        int episodeNumber,
        int seasonNumber,
        String timestamp,
        this._quality,
    ) : super(seriesID, showTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, 'downloadFolderImported');

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.sonarrEventTypeMessages[eventType]} ($_quality)',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class SonarrHistoryEntryDownloadFailed extends SonarrHistoryEntry {
    SonarrHistoryEntryDownloadFailed (
        int seriesID,
        String showTitle,
        String episodeTitle,
        int episodeNumber,
        int seasonNumber,
        String timestamp,
    ) : super(seriesID, showTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, 'downloadFailed');

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.sonarrEventTypeMessages[eventType]}',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class SonarrHistoryEntryGrabbed extends SonarrHistoryEntry {
    String _indexer;

    SonarrHistoryEntryGrabbed (
        int seriesID,
        String showTitle,
        String episodeTitle,
        int episodeNumber,
        int seasonNumber,
        String timestamp,
        this._indexer,
    ) : super(seriesID, showTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, 'grabbed');

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.sonarrEventTypeMessages[eventType]} $_indexer',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}
