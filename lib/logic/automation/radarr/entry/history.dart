import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

abstract class RadarrHistoryEntry {
    String movieTitle;
    String timestamp;
    String eventType;

    RadarrHistoryEntry(
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

class RadarrHistoryEntryGeneric extends RadarrHistoryEntry {
    String _eventType;

    RadarrHistoryEntryGeneric(
        String movieTitle,
        String timestamp,
        this._eventType,
    ) : super(movieTitle, timestamp, _eventType);

    @override
    List<TextSpan> get subtitle {
        return [
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

class RadarrHistoryEntryFileRenamed extends RadarrHistoryEntry {
    RadarrHistoryEntryFileRenamed(
        String movieTitle,
        String timestamp,
    ) : super(movieTitle, timestamp, 'movieFileRenamed');

    @override
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

class RadarrHistoryEntryFileDeleted extends RadarrHistoryEntry {
    String _reason;

    RadarrHistoryEntryFileDeleted(
        String movieTitle,
        String timestamp,
        this._reason,
    ) : super(movieTitle, timestamp, 'movieFileDeleted');

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.radarrEventTypeMessages[eventType]} (${Constants.historyReasonMessages[_reason] ?? _reason})',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class RadarrHistoryEntryDownloadImported extends RadarrHistoryEntry {
    String _quality;

    RadarrHistoryEntryDownloadImported(
        String movieTitle,
        String timestamp,
        this._quality,
    ) : super(movieTitle, timestamp, 'downloadFolderImported');

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.radarrEventTypeMessages[eventType]} ($_quality)',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            ),
        ];
    }
}

class RadarrHistoryEntryDownloadFailed extends RadarrHistoryEntry {
    RadarrHistoryEntryDownloadFailed(
        String movieTitle,
        String timestamp,
    ) : super(movieTitle, timestamp, 'downloadFailed');

    @override
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

class RadarrHistoryEntryGrabbed extends RadarrHistoryEntry {
    String _indexer;

    RadarrHistoryEntryGrabbed(
        String movieTitle,
        String timestamp,
        this._indexer,
    ) : super(movieTitle, timestamp, 'grabbed');

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.radarrEventTypeMessages[eventType]} $_indexer',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}