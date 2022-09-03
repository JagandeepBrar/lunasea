import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'queue.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SABnzbdQueue {
  SABnzbdQueueResult queue;

  SABnzbdQueue({
    required this.queue,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SABnzbdQueue.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdQueueFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdQueueToJson(this);
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SABnzbdQueueResult {
  String status;
  bool paused;
  List<SABnzbdQueueSlot> slots;

  @JsonKey(name: 'kbpersec')
  String speed;

  @JsonKey(name: 'timeleft')
  String timeLeft;

  @JsonKey(name: 'mb')
  String size;

  @JsonKey(name: 'mbleft')
  String sizeLeft;

  SABnzbdQueueResult({
    required this.status,
    required this.paused,
    required this.speed,
    required this.timeLeft,
    required this.size,
    required this.sizeLeft,
    required this.slots,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SABnzbdQueueResult.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdQueueResultFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdQueueResultToJson(this);
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SABnzbdQueueSlot {
  String filename;
  String status;
  String script;
  String priority;

  @JsonKey(name: 'nzo_id')
  String nzoId;

  @JsonKey(name: 'mb')
  String size;

  @JsonKey(name: 'mbleft')
  String sizeLeft;

  @JsonKey(name: 'timeleft')
  String timeLeft;

  @JsonKey(name: 'cat')
  String category;

  SABnzbdQueueSlot({
    required this.filename,
    required this.status,
    required this.script,
    required this.priority,
    required this.nzoId,
    required this.size,
    required this.sizeLeft,
    required this.timeLeft,
    required this.category,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SABnzbdQueueSlot.fromJson(Map<String, dynamic> json) {
    return _$SABnzbdQueueSlotFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SABnzbdQueueSlotToJson(this);
  }
}
