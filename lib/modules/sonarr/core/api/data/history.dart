import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

abstract class SonarrHistoryData {
    String seriesTitle;
    String episodeTitle;
    String timestamp;
    String eventType;
    int seriesID;
    int episodeNumber;
    int seasonNumber;

    SonarrHistoryData(
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

    List<TextSpan> get subtitle;
}

class SonarrHistoryDataGeneric extends SonarrHistoryData {
    String eventType;

    SonarrHistoryDataGeneric({
        @required int seriesID,
        @required String seriesTitle,
        @required String episodeTitle,
        @required int episodeNumber,
        @required int seasonNumber,
        @required String timestamp,
        @required this.eventType,
    }) : super(seriesID, seriesTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, eventType);

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '$eventType',
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class SonarrHistoryDataEpisodeRenamed extends SonarrHistoryData {
    SonarrHistoryDataEpisodeRenamed({
        @required int seriesID,
        @required String seriesTitle,
        @required String episodeTitle,
        @required int episodeNumber,
        @required int seasonNumber,
        @required String timestamp,
    }) : super(seriesID, seriesTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, 'episodeFileRenamed');

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${SonarrConstants.EVENT_TYPE_MESSAGES[eventType]}',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class SonarrHistoryDataEpisodeDeleted extends SonarrHistoryData {
    String reason;

    SonarrHistoryDataEpisodeDeleted ({
        @required int seriesID,
        @required String seriesTitle,
        @required String episodeTitle,
        @required int episodeNumber,
        @required int seasonNumber,
        @required String timestamp,
        @required this.reason,
    }) : super(seriesID, seriesTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, 'episodeFileDeleted');

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${SonarrConstants.EVENT_TYPE_MESSAGES[eventType]} (${Constants.historyReasonMessages[reason] ?? reason})',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class SonarrHistoryDataDownloadImported extends SonarrHistoryData {
    String quality;

    SonarrHistoryDataDownloadImported ({
        @required int seriesID,
        @required String seriesTitle,
        @required String episodeTitle,
        @required int episodeNumber,
        @required int seasonNumber,
        @required String timestamp,
        @required this.quality,
    }) : super(seriesID, seriesTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, 'downloadFolderImported');

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${SonarrConstants.EVENT_TYPE_MESSAGES[eventType]} ($quality)',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class SonarrHistoryDataDownloadFailed extends SonarrHistoryData {
    SonarrHistoryDataDownloadFailed({
        @required int seriesID,
        @required String seriesTitle,
        @required String episodeTitle,
        @required int episodeNumber,
        @required int seasonNumber,
        @required String timestamp,
    }) : super(seriesID, seriesTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, 'downloadFailed');

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${SonarrConstants.EVENT_TYPE_MESSAGES[eventType]}',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class SonarrHistoryDataGrabbed extends SonarrHistoryData {
    String indexer;

    SonarrHistoryDataGrabbed ({
        @required int seriesID,
        @required String seriesTitle,
        @required String episodeTitle,
        @required int episodeNumber,
        @required int seasonNumber,
        @required String timestamp,
        @required this.indexer,
    }) : super(seriesID, seriesTitle, episodeTitle, episodeNumber, seasonNumber, timestamp, 'grabbed');

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: 'Season $seasonNumber Episode $episodeNumber\n',
            ),
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${SonarrConstants.EVENT_TYPE_MESSAGES[eventType]} $indexer',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}
