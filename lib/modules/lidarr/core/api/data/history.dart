import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

abstract class LidarrHistoryData {
    String title;
    String timestamp;
    String eventType;
    int artistID;
    int albumID;

    LidarrHistoryData(
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

class LidarrHistoryDataGeneric extends LidarrHistoryData {
    String eventType;

    LidarrHistoryDataGeneric({
        @required String title,
        @required String timestamp,
        @required this.eventType,
        @required int artistID,
        @required int albumID,
    }) : super(title, timestamp, eventType, artistID, albumID);

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

class LidarrHistoryDataGrabbed extends LidarrHistoryData {
    String indexer;

    LidarrHistoryDataGrabbed({
        @required String title,
        @required String timestamp,
        @required this.indexer,
        @required int artistID,
        @required int albumID,
    }) : super(title, timestamp, 'grabbed', artistID, albumID);

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${LidarrConstants.EVENT_TYPE_MESSAGES[eventType]} $indexer',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}

class LidarrHistoryDataTrackFileImported extends LidarrHistoryData {
    String quality;

    LidarrHistoryDataTrackFileImported({
        @required String title,
        @required String timestamp,
        @required this.quality,
        @required int artistID,
        @required int albumID,
    }) : super(title, timestamp, 'trackFileImported', artistID, albumID);

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${LidarrConstants.EVENT_TYPE_MESSAGES[eventType]} ($quality)',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}

class LidarrHistoryDataDownloadImported extends LidarrHistoryData {
    String quality;

    LidarrHistoryDataDownloadImported({
        @required String title,
        @required String timestamp,
        @required this.quality,
        @required int artistID,
        @required int albumID,
    }) : super(title, timestamp, 'downloadImported', artistID, albumID);

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${LidarrConstants.EVENT_TYPE_MESSAGES[eventType]} ($quality)',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}

class LidarrHistoryDataAlbumImportIncomplete extends LidarrHistoryData {
    LidarrHistoryDataAlbumImportIncomplete({
        @required String title,
        @required String timestamp,
        @required int artistID,
        @required int albumID,
    }) : super(title, timestamp, 'albumImportIncomplete', artistID, albumID);

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${LidarrConstants.EVENT_TYPE_MESSAGES[eventType]}',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}

class LidarrHistoryDataTrackFileDeleted extends LidarrHistoryData {
    String reason;

    LidarrHistoryDataTrackFileDeleted({
        @required String title,
        @required String timestamp,
        @required this.reason,
        @required int artistID,
        @required int albumID,
    }) : super(title, timestamp, 'trackFileDeleted', artistID, albumID);

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${LidarrConstants.EVENT_TYPE_MESSAGES[eventType]} (${Constants.historyReasonMessages[reason] ?? reason})',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}

class LidarrHistoryDataTrackFileRenamed extends LidarrHistoryData {
    LidarrHistoryDataTrackFileRenamed({
        @required String title,
        @required String timestamp,
        @required int artistID,
        @required int albumID,
    }) : super(title, timestamp, 'trackFileRenamed', artistID, albumID);

    List<TextSpan> get subtitle {
        return [
            TextSpan(
                text: '$timestampString\n',
            ),
            TextSpan(
                text: '${LidarrConstants.EVENT_TYPE_MESSAGES[eventType]}',
                style: TextStyle(
                    color: Color(Constants.ACCENT_COLOR),
                    fontWeight: FontWeight.bold,
                ),
            )
        ];
    }
}