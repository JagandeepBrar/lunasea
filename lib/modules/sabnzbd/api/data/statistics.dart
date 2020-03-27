import 'package:lunasea/core.dart';

class SABnzbdStatisticsData {
    List<String> servers;
    String uptime;
    String version;
    double freespace;
    double speedlimit;
    int speedlimitPercentage;
    int dailyUsage;
    int weeklyUsage;
    int monthlyUsage;
    int totalUsage;

    SABnzbdStatisticsData(
        this.servers,
        this.uptime,
        this.version,
        this.speedlimit,
        this.speedlimitPercentage,
        this.freespace,
        this.dailyUsage,
        this.weeklyUsage,
        this.monthlyUsage,
        this.totalUsage,
    );

    String get speed {
        String _speed = speedlimit?.floor()?.lsBytes_BytesToString();
        return '$_speed/s ($speedlimitPercentage%)';
    }
}
