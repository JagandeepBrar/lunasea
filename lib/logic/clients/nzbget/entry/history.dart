import 'package:flutter/material.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/functions.dart';

class NZBGetHistoryEntry {
    int id;
    String name;
    String status;
    int timestamp;
    int downloadedLow;
    int downloadedHigh;
    DateTime now = DateTime.now();
    
    NZBGetHistoryEntry(
        this.id,
        this.name,
        this.status,
        this.timestamp,
        this.downloadedLow,
        this.downloadedHigh,
    );

    int get downloaded {
        return (downloadedHigh << 32)+downloadedLow;
    }

    String get sizeReadable {
        return Functions.bytesToReadable(downloaded, decimals: 2);
    }

    DateTime get timestampObject {
        return timestamp == -1 ? null : DateTime.fromMillisecondsSinceEpoch(timestamp*1000);
    }

    String get completeTime {
        return '${Functions.timestampDifference(now, timestampObject)}';
    }

    TextSpan get getStatus {
        switch(status) {
            case 'SUCCESS/UNPACK':
            case 'SUCCESS/PAR':
            case 'SUCCESS/HEALTH':
            case 'SUCCESS/GOOD':
            case 'SUCCESS/MARK':
            case 'SUCCESS/HIDDEN':
            case 'SUCCESS/ALL': {
                return TextSpan(
                    text: 'Completed (${status.substring('SUCCESS/'.length)})',
                    style: TextStyle(
                        color: Color(Constants.ACCENT_COLOR),
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            case 'WARNING/SCRIPT':
            case 'WARNING/SPACE':
            case 'WARNING/PASSWORD':
            case 'WARNING/DAMAGED':
            case 'WARNING/REPAIRABLE':
            case 'WARNING/HEALTH':
            case 'WARNING/SKIPPED': {
                return TextSpan(
                    text: 'Warning (${status.substring('WARNING/'.length)})',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            case 'DELETED/MANUAL':
            case 'DELETED/DUPE':
            case 'DELETED/COPY':
            case 'DELETED/GOOD': {
                return TextSpan(
                    text: 'Deleted (${status.substring('DELETED/'.length)})',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            case 'FAILURE/PAR':
            case 'FAILURE/UNPACK':
            case 'FAILURE/MOVE':
            case 'FAILURE/SCAN':
            case 'FAILURE/BAD':
            case 'FAILURE/HEALTH':
            case 'FAILURE/FETCH':
            case 'FAILURE/HIDDEN': {
                return TextSpan(
                    text: 'Failure (${status.substring('FAILURE/'.length)})',
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
            default: {
                return TextSpan(
                    text: status,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                    ),
                );
            }
        }
    }
}