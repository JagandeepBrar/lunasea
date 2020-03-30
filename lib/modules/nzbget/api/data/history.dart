import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class NZBGetHistoryData {
    int id;
    String name;
    String status;
    String category;
    String storageLocation;
    int timestamp;
    int downloadedLow;
    int downloadedHigh;
    int downloadTime;
    int health;
    DateTime now = DateTime.now();
    
    NZBGetHistoryData({
        @required this.id,
        @required this.name,
        @required this.status,
        @required this.timestamp,
        @required this.downloadedLow,
        @required this.downloadedHigh,
        @required this.category,
        @required this.storageLocation,
        @required this.downloadTime,
        @required this.health,
    });

    int get downloaded {
        return (downloadedHigh << 32)+downloadedLow;
    }

    String get downloadSpeed {
        if(downloadTime == 0) {
            return '0.00 MB/s';
        } else {
            int speed = (downloaded/downloadTime).floor();
            return '${speed?.lsBytes_BytesToString()}/s';
        }
    }

    String get sizeReadable {
        return downloaded?.lsBytes_BytesToString();
    }

    DateTime get timestampObject {
        return timestamp == -1 ? null : DateTime.fromMillisecondsSinceEpoch(timestamp*1000);
    }

    String get completeTime {
        return now.lsDateTime_ageString(timestampObject);
    }

    String get healthString {
        return '${(health/10).toStringAsFixed(1)}%';
    }

    bool get isHideable {
        return status.substring(0, 7) == 'SUCCESS';
    }

    bool get failed {
        return status.substring(0, 7) == 'FAILURE';
    }

    Color get statusColor {
        switch(status.substring(0, 7)) {
            case 'SUCCESS': return Color(Constants.ACCENT_COLOR);
            case 'WARNING': return Colors.orange;
            case 'DELETED': return Colors.deepPurpleAccent;
            case 'FAILURE': return Colors.red;
            default: return Colors.blueGrey;
        }
    }

    String get statusString {
        switch(status.substring(0, 7)) {
            case 'SUCCESS': return 'Completed (${status.substring('SUCCESS/'.length)})';
            case 'WARNING': return 'Warning (${status.substring('WARNING/'.length)})';
            case 'DELETED': return 'Deleted (${status.substring('DELETED/'.length)})';
            case 'FAILURE': return 'Failure (${status.substring('FAILURE/'.length)})';
            default: return status;
        }
    }
}