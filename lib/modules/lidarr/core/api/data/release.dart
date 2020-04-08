import 'package:flutter/material.dart';

class LidarrReleaseData {
    String title;
    String guid;
    String quality;
    String protocol;
    String indexer;
    String infoUrl;
    bool approved;
    int releaseWeight;
    int size;
    int indexerId;
    int seeders;
    int leechers;
    double ageHours;
    List<dynamic> rejections;

    LidarrReleaseData({
        @required this.title,
        @required this.guid,
        @required this.quality,
        @required this.protocol,
        @required this.indexer,
        @required this.infoUrl,
        @required this.approved,
        @required this.releaseWeight,
        @required this.size,
        @required this.indexerId,
        @required this.ageHours,
        @required this.rejections,
        @required this.seeders,
        @required this.leechers,
    });

    bool get isTorrent {
        return protocol == 'torrent';
    }
}
