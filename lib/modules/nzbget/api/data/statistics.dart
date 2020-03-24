import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class NZBGetStatisticsData {
    int freeSpaceHigh;
    int freeSpaceLow;
    int downloadedHigh;
    int downloadedLow;
    int uptimeSeconds;
    int speedLimit;
    bool serverPaused;
    bool postPaused;
    bool scanPaused;

    NZBGetStatisticsData({
        @required this.freeSpaceHigh,
        @required this.freeSpaceLow,
        @required this.downloadedHigh,
        @required this.downloadedLow,
        @required this.uptimeSeconds,
        @required this.speedLimit,
        @required this.serverPaused,
        @required this.postPaused,
        @required this.scanPaused,
    });

    int get freeSpace {
        return (freeSpaceHigh << 32)+freeSpaceLow;
    }

    int get downloaded {
        return (downloadedHigh << 32)+downloadedLow;
    }

    String get freeSpaceString {
        return freeSpace?.lsBytes_BytesToString(decimals: 1);
    }

    String get downloadedString {
        return downloaded?.lsBytes_BytesToString(decimals: 1);
    }

    String get uptimeString {
        return uptimeSeconds.lsTime_durationString();
    }

    String get speedLimitString {
        String limit = speedLimit?.lsBytes_BytesToString();
        return limit == '0.00 B' ? 'No Limit Set' : '$limit/s';
    }
}
