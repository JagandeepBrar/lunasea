import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class NZBGetStatus {
  @JsonKey(name: 'DownloadPaused')
  bool paused;

  @JsonKey(name: 'DownloadRate')
  int speed;

  @JsonKey(name: 'DownloadLimit')
  int speedLimit;

  @JsonKey(name: 'RemainingSizeMB')
  int remainingSize;

  NZBGetStatus({
    required this.paused,
    required this.speed,
    required this.speedLimit,
    required this.remainingSize,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory NZBGetStatus.fromJson(Map<String, dynamic> json) {
    return _$NZBGetStatusFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NZBGetStatusToJson(this);
  }
}
