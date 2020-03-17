import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

abstract class RadarrHistoryData {
    String movieTitle;
    String timestamp;
    String eventType;

    RadarrHistoryData(
        this.movieTitle,
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

class RadarrHistoryDataGeneric extends RadarrHistoryData {
    String eventType;

    RadarrHistoryDataGeneric({
        @required String movieTitle,
        @required String timestamp,
        @required this.eventType,
    }) : super(movieTitle, timestamp, eventType);

    List<TextSpan> get subtitle {
        return [
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

class RadarrHistoryDataFileRenamed extends RadarrHistoryData {
    RadarrHistoryDataFileRenamed({
        @required String movieTitle,
        @required String timestamp,
    }) : super(movieTitle, timestamp, 'movieFileRenamed');

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.radarrEventTypeMessages[eventType]}',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class RadarrHistoryDataFileDeleted extends RadarrHistoryData {
    String reason;

    RadarrHistoryDataFileDeleted({
        @required String movieTitle,
        @required String timestamp,
        @required this.reason,
    }) : super(movieTitle, timestamp, 'movieFileDeleted');

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.radarrEventTypeMessages[eventType]} (${Constants.historyReasonMessages[reason] ?? reason})',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class RadarrHistoryDataDownloadImported extends RadarrHistoryData {
    String quality;

    RadarrHistoryDataDownloadImported({
        @required String movieTitle,
        @required String timestamp,
        @required this.quality,
    }) : super(movieTitle, timestamp, 'downloadFolderImported');

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.radarrEventTypeMessages[eventType]} ($quality)',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class RadarrHistoryDataDownloadFailed extends RadarrHistoryData {
    RadarrHistoryDataDownloadFailed({
        @required String movieTitle,
        @required String timestamp,
    }) : super(movieTitle, timestamp, 'downloadFailed');

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.radarrEventTypeMessages[eventType]}',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class RadarrHistoryDataGrabbed extends RadarrHistoryData {
    String indexer;

    RadarrHistoryDataGrabbed({
        @required String movieTitle,
        @required String timestamp,
        @required this.indexer,
    }) : super(movieTitle, timestamp, 'grabbed');

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.radarrEventTypeMessages[eventType]} $indexer',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}