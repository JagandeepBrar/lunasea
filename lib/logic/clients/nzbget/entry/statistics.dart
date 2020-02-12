import 'package:lunasea/core.dart';

class NZBGetStatisticsEntry {
    int freeSpaceHigh;
    int freeSpaceLow;
    int downloadedHigh;
    int downloadedLow;
    int uptimeSeconds;
    int speedLimit;
    bool serverPaused;
    bool postPaused;
    bool scanPaused;

    NZBGetStatisticsEntry(
        this.freeSpaceHigh,
        this.freeSpaceLow,
        this.downloadedHigh,
        this.downloadedLow,
        this.uptimeSeconds,
        this.speedLimit,
        this.serverPaused,
        this.postPaused,
        this.scanPaused,
    );

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
        return Functions.secondsToString(uptimeSeconds);
    }

    String get speedLimitString {
        String limit = speedLimit?.lsBytes_BytesToString();
        return limit == '0.00 B' ? 'No Limit Set' : '$limit/s';
    }
}
