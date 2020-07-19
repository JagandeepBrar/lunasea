import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SABnzbdHistoryData {
    String nzoId;
    String name;
    String failureMessage;
    String category;
    int size;
    int timestamp;
    int downloadTime;
    String status;
    String actionLine;
    String storageLocation;
    List<dynamic> stageLog;
    DateTime now = DateTime.now();

    SABnzbdHistoryData({
        @required this.nzoId,
        @required this.name,
        @required this.size,
        @required this.status,
        @required this.failureMessage,
        @required this.timestamp,
        @required this.actionLine,
        @required this.category,
        @required this.downloadTime,
        @required this.stageLog,
        @required this.storageLocation,
    });

    DateTime get completeTimeObject {
        return DateTime.fromMillisecondsSinceEpoch(timestamp*1000);
    }

    String get completeTimeString {
        return now?.lsDateTime_ageString(completeTimeObject) ?? 'Unknown Time';
    }

    String get sizeReadable {
        return size?.lsBytes_BytesToString() ?? 'Unknown Size';
    }

    bool get failed {
        return status.toLowerCase() == 'failed';
    }

    Color get statusColor {
        switch(status.toLowerCase()) {
            case 'completed': return LSColors.accent;
            case 'queued': return LSColors.blue;
            case 'extracting': return LSColors.orange;
            case 'failed': return LSColors.red;
        }
        return LSColors.purple;
    }

    String get statusString {
        switch(status.toLowerCase()) {
            case 'completed': return 'Completed'; break;
            case 'queued':
            case 'extracting': return actionLine; break;
            case 'failed': return failureMessage; break;
            default: return status; break;
        }
    }
}
