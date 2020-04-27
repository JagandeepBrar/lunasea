import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdStatisticsData {
    List<SABnzbdServerStatisticsData> servers;
    String uptime;
    String version;
    double freespace;
    double speedlimit;
    int speedlimitPercentage;
    int dailyUsage;
    int weeklyUsage;
    int monthlyUsage;
    int totalUsage;

    SABnzbdStatisticsData({
        @required this.servers,
        @required this.uptime,
        @required this.version,
        @required this.speedlimit,
        @required this.speedlimitPercentage,
        @required this.freespace,
        @required this.dailyUsage,
        @required this.weeklyUsage,
        @required this.monthlyUsage,
        @required this.totalUsage,
    });

    String get speed {
        String _speed = speedlimit?.floor()?.lsBytes_BytesToString();
        return '$_speed/s ($speedlimitPercentage%)';
    }
}
