import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'stage_log.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SABnzbdStageLog {
  String name;
  List<String> actions;

  SABnzbdStageLog({
    required this.name,
    required this.actions,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SABnzbdStageLog.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdStageLogFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdStageLogToJson(this);
  }
}
