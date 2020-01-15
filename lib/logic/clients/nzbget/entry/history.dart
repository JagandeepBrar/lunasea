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
                    text: 'Completed',
                    style: TextStyle(
                        color: Color(Constants.ACCENT_COLOR),
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