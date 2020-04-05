import 'package:flutter/material.dart';

class SonarrQueueData {
    int episodeID;
    double size;
    double sizeLeft;
    String status;
    String seriesTitle;
    String releaseTitle;
    int seasonNumber;
    int episodeNumber;

    SonarrQueueData({
        @required this.episodeID,
        @required this.size,
        @required this.sizeLeft,
        @required this.status,
        @required this.seriesTitle,
        @required this.releaseTitle,
        @required this.seasonNumber,
        @required this.episodeNumber,
    });
}
