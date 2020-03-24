import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class NZBGetQueueData {
    int id;
    String name;
    String status;
    String category;
    int remaining;
    int downloaded;
    int sizeTotal;
    int speed;
    int queueSeconds;

    NZBGetQueueData({
        @required this.id,
        @required this.name,
        @required this.status,
        @required this.remaining,
        @required this.downloaded,
        @required this.sizeTotal,
        @required this.category,
        @required this.speed,
        @required this.queueSeconds,
    });

    int get percentageDone {
        return sizeTotal == 0 ? 0 : ((downloaded/sizeTotal)*100).round();
    }

    bool get paused {
        return status == 'PAUSED';
    }

    double get speedMB {
        return speed/(1024*1024);
    }

    int get remainingTime {
        return speedMB == 0 ? 0 : (remaining/speedMB).floor();
    }

    String get timestamp {
        return (queueSeconds+remainingTime).lsTime_timestampString() == '0:00:00' ? '―' : (queueSeconds+remainingTime).lsTime_timestampString();
    }

    String get statusString {
        switch(status) {
            case 'DOWNLOADING':
            case 'QUEUED': {
                return speed == -1 ? 'Downloading' : timestamp;
            }
            case 'PAUSED': {
                return 'Paused';
            }
            default: {
                return status;
            }
        }
    }

    String get subtitle {
        String size = '$downloaded/$sizeTotal MB';
        return '$statusString\t•\t$size\t•\t$percentageDone%';
    }
}
