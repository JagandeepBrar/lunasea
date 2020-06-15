import 'package:flutter/material.dart';

class SABnzbdServerStatisticsData {
    String name;
    int dailyUsage;
    int weeklyUsage;
    int monthlyUsage;
    int totalUsage;

    SABnzbdServerStatisticsData({
        @required this.name,
        @required this.dailyUsage,
        @required this.weeklyUsage,
        @required this.monthlyUsage,
        @required this.totalUsage,
    });
}
