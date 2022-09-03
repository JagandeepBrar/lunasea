import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'server.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SABnzbdServer {
  @JsonKey(name: 'day')
  int dailyUsage;

  @JsonKey(name: 'week')
  int weeklyUsage;

  @JsonKey(name: 'month')
  int monthlyUsage;

  @JsonKey(name: 'total')
  int totalUsage;

  SABnzbdServer({
    required this.dailyUsage,
    required this.weeklyUsage,
    required this.monthlyUsage,
    required this.totalUsage,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SABnzbdServer.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdServerFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdServerToJson(this);
  }
}
