import 'package:flutter/material.dart';

class SonarrQueueData {
    int episodeID;
    double size;
    double sizeLeft;
    String status;

    SonarrQueueData({
        @required this.episodeID,
        @required this.size,
        @required this.sizeLeft,
        @required this.status,
    });
}
