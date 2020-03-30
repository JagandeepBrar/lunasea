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

    TextSpan get getStatus {
        switch(status.toLowerCase()) {
            case 'completed': {
                return TextSpan(
                    text: 'Completed',
                    style: TextStyle(
                        color: Color(Constants.ACCENT_COLOR),
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            case 'queued': {
                return TextSpan(
                    text: actionLine,
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            case 'extracting': {
                return TextSpan(
                    text: actionLine,
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            case 'failed': {
                return TextSpan(
                    text: failureMessage,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            default: {
                return TextSpan(
                    text: status,
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
        }
    }
}
