import 'package:flutter/material.dart';
import 'package:lunasea/system/constants.dart';

abstract class LidarrHistoryEntry {
    String title;
    String timestamp;
    String eventType;
    int artistID;
    int albumID;

    LidarrHistoryEntry(
        this.title,
        this.timestamp,
        this.eventType,
        this.artistID,
        this.albumID,
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

class LidarrHistoryEntryGeneric extends LidarrHistoryEntry {
    String _eventType;

    LidarrHistoryEntryGeneric(
        String title,
        String timestamp,
        this._eventType,
        int artistID,
        int albumID,
    ) : super(title, timestamp, _eventType, artistID, albumID);

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

class LidarrHistoryEntryGrabbed extends LidarrHistoryEntry {
    String _indexer;

    LidarrHistoryEntryGrabbed(
        String title,
        String timestamp,
        this._indexer,
        int artistID,
        int albumID,
    ) : super(title, timestamp, 'grabbed', artistID, albumID);

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.lidarrEventTypeMessages[eventType]} $_indexer',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}

class LidarrHistoryEntryTrackFileImported extends LidarrHistoryEntry {
    String _quality;

    LidarrHistoryEntryTrackFileImported(
        String title,
        String timestamp,
        this._quality,
        int artistID,
        int albumID,
    ) : super(title, timestamp, 'trackFileImported', artistID, albumID);

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.lidarrEventTypeMessages[eventType]} ($_quality)',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}

class LidarrHistoryEntryDownloadImported extends LidarrHistoryEntry {
    String _quality;

    LidarrHistoryEntryDownloadImported(
        String title,
        String timestamp,
        this._quality,
        int artistID,
        int albumID,
    ) : super(title, timestamp, 'downloadImported', artistID, albumID);

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.lidarrEventTypeMessages[eventType]} ($_quality)',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}

class LidarrHistoryEntryAlbumImportIncomplete extends LidarrHistoryEntry {
    LidarrHistoryEntryAlbumImportIncomplete(
        String title,
        String timestamp,
        int artistID,
        int albumID,
    ) : super(title, timestamp, 'albumImportIncomplete', artistID, albumID);

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.lidarrEventTypeMessages[eventType]}',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}

class LidarrHistoryEntryTrackFileDeleted extends LidarrHistoryEntry {
    String _reason;

    LidarrHistoryEntryTrackFileDeleted(
        String title,
        String timestamp,
        this._reason,
        int artistID,
        int albumID,
    ) : super(title, timestamp, 'trackFileDeleted', artistID, albumID);

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.lidarrEventTypeMessages[eventType]} (${Constants.historyReasonMessages[_reason] ?? _reason})',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}

class LidarrHistoryEntryTrackFileRenamed extends LidarrHistoryEntry {
    LidarrHistoryEntryTrackFileRenamed(
        String title,
        String timestamp,
        int artistID,
        int albumID,
    ) : super(title, timestamp, 'trackFileRenamed', artistID, albumID);

    @override
    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${Constants.lidarrEventTypeMessages[eventType]}',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}