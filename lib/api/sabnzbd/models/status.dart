import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SABnzbdStatus {
  _SABnzbdStatusResult status;

  SABnzbdStatus({
    required this.status,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SABnzbdStatus.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdStatusFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdStatusToJson(this);
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _SABnzbdStatusResult {
  String uptime;
  String version;
  bool paused;

  @JsonKey(name: 'diskspace1')
  String tempDiskSpace;

  @JsonKey(name: 'diskspace2')
  String finalDiskSpace;

  @JsonKey(name: 'speedlimit_abs')
  String speedLimit;

  @JsonKey(name: 'speedlimit')
  String speedLimitPercentage;

  _SABnzbdStatusResult({
    required this.uptime,
    required this.version,
    required this.paused,
    required this.tempDiskSpace,
    required this.finalDiskSpace,
    required this.speedLimit,
    required this.speedLimitPercentage,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory _SABnzbdStatusResult.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdStatusResultFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdStatusResultToJson(this);
  }
}
