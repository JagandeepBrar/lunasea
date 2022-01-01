import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdStatisticsData {
  List<SABnzbdServerStatisticsData> servers;
  String uptime;
  String version;
  double tempFreespace;
  double finalFreespace;
  double? speedlimit;
  int speedlimitPercentage;
  int dailyUsage;
  int weeklyUsage;
  int monthlyUsage;
  int totalUsage;

  SABnzbdStatisticsData({
    required this.servers,
    required this.uptime,
    required this.version,
    required this.speedlimit,
    required this.speedlimitPercentage,
    required this.tempFreespace,
    required this.finalFreespace,
    required this.dailyUsage,
    required this.weeklyUsage,
    required this.monthlyUsage,
    required this.totalUsage,
  });
}
