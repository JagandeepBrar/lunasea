import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';

class SABnzbdHistoryEntry {
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

    SABnzbdHistoryEntry(
        this.nzoId,
        this.name,
        this.size,
        this.status,
        this.failureMessage,
        this.timestamp,
        this.actionLine,
        this.category,
        this.downloadTime,
        this.stageLog,
        this.storageLocation,
    );

    DateTime get completeTimeObject {
        return DateTime.fromMillisecondsSinceEpoch(timestamp*1000);
    }

    String get completeTimeString {
        return now.lsDateTime_ageString(completeTimeObject);
    }

    String get sizeReadable {
        return size?.lsBytes_BytesToString();
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
