import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/sabnzbd/models/stage_log.dart';

part 'history.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SABnzbdHistory {
  _SABnzbdHistoryResult history;

  SABnzbdHistory({
    required this.history,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SABnzbdHistory.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdHistoryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdHistoryToJson(this);
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _SABnzbdHistoryResult {
  List<_SABnzbdHistorySlot> slots;

  @JsonKey(name: 'day_size')
  String dailySize;

  @JsonKey(name: 'week_size')
  String weeklySize;

  @JsonKey(name: 'month_size')
  String monthlySize;

  @JsonKey(name: 'total_size')
  String totalSize;

  _SABnzbdHistoryResult({
    required this.slots,
    required this.dailySize,
    required this.weeklySize,
    required this.monthlySize,
    required this.totalSize,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory _SABnzbdHistoryResult.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdHistoryResultFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdHistoryResultToJson(this);
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _SABnzbdHistorySlot {
  String name;
  String status;
  String script;
  String category;
  String storage;

  @JsonKey(name: 'completed')
  int timestamp;

  @JsonKey(name: 'nzo_id')
  String nzoId;

  @JsonKey(name: 'bytes')
  int size;

  @JsonKey(name: 'fail_message')
  String failMessage;

  @JsonKey(name: 'action_line')
  String actionLine;

  @JsonKey(name: 'download_time')
  int downloadTime;

  @JsonKey(name: 'stage_log')
  List<SABnzbdStageLog> stageLog;

  _SABnzbdHistorySlot({
    required this.name,
    required this.status,
    required this.script,
    required this.category,
    required this.nzoId,
    required this.size,
    required this.failMessage,
    required this.timestamp,
    required this.actionLine,
    required this.downloadTime,
    required this.stageLog,
    required this.storage,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory _SABnzbdHistorySlot.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdHistorySlotFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdHistorySlotToJson(this);
  }
}
