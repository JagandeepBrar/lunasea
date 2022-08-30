import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'activity.g.dart';

/// Model for activity data from Tautulli.
///
/// Each individual session data is stored in `sessions`, with each session being a [TautulliSession].
@JsonSerializable(explicitToJson: true)
class TautulliActivity {
  /// List of [TautulliSession], each storing a single active session.
  @JsonKey(
      name: 'sessions', toJson: _sessionsToJson, fromJson: _sessionsFromJson)
  final List<TautulliSession>? sessions;

  /// Total number of active streams.
  @JsonKey(
      name: 'stream_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamCount;

  /// Total number of _direct play_ active streams.
  @JsonKey(
      name: 'stream_count_direct_play',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamCountDirectPlay;

  /// Total number of _direct stream_ active streams.
  @JsonKey(
      name: 'stream_count_direct_stream',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamCountDirectStream;

  /// Total number of _transcode_ active streams.
  @JsonKey(
      name: 'stream_count_transcode',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamCountTranscode;

  /// Total bandwidth usage by all streams.
  @JsonKey(
      name: 'total_bandwidth',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? totalBandwidth;

  /// Total bandwidth usage on your local area network (internal, LAN).
  @JsonKey(
      name: 'lan_bandwidth', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? lanBandwidth;

  /// Total bandwidth usage on your wide area network (external, WAN).
  @JsonKey(
      name: 'wan_bandwidth', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? wanBandwidth;

  TautulliActivity({
    this.streamCount,
    this.streamCountDirectPlay,
    this.streamCountDirectStream,
    this.streamCountTranscode,
    this.totalBandwidth,
    this.lanBandwidth,
    this.wanBandwidth,
    this.sessions,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliActivity] object.
  factory TautulliActivity.fromJson(Map<String, dynamic> json) =>
      _$TautulliActivityFromJson(json);

  /// Serialize a [TautulliActivity] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliActivityToJson(this);

  static List<TautulliSession> _sessionsFromJson(
          List<dynamic> sessions) =>
      sessions
          .map((session) =>
              TautulliSession.fromJson((session as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _sessionsToJson(
          List<TautulliSession>? sessions) =>
      sessions?.map((session) => session.toJson()).toList();
}
