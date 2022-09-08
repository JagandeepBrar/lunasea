import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/sabnzbd/models/server.dart';

part 'server_stats.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SABnzbdServerStats {
  @JsonKey(name: 'day')
  int dailyUsage;

  @JsonKey(name: 'week')
  int weeklyUsage;

  @JsonKey(name: 'month')
  int monthlyUsage;

  @JsonKey(name: 'total')
  int totalUsage;

  Map<String, SABnzbdServer> servers;

  SABnzbdServerStats({
    required this.dailyUsage,
    required this.weeklyUsage,
    required this.monthlyUsage,
    required this.totalUsage,
    required this.servers,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SABnzbdServerStats.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdServerStatsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdServerStatsToJson(this);
  }
}
