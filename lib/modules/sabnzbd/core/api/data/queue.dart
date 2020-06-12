import 'package:flutter/material.dart';

class SABnzbdQueueData {
    String name;
    String nzoId;
    String status;
    String timeLeft;
    String category;
    int sizeTotal;
    int sizeLeft;

    SABnzbdQueueData({
        @required this.name,
        @required this.nzoId,
        @required this.sizeTotal,
        @required this.sizeLeft,
        @required this.status,
        @required this.timeLeft,
        @required this.category,
    });

    int get percentageDone {
        return sizeTotal == 0 ? 0 : (((sizeTotal-sizeLeft)/sizeTotal)*100).round() ?? 0.0;
    }

    String get subtitle {
        String time = isPaused ?
            'Paused' :
            timeLeft == '0:00:00' ?
                '―' :
                timeLeft;
        String size = '${sizeTotal-sizeLeft}/$sizeTotal MB';
        return '$time\t•\t$size\t•\t$percentageDone%';
    }

    bool get isPaused {
        return status.toLowerCase() == 'paused';
    }
}
