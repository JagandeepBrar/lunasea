// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliActivity _$TautulliActivityFromJson(Map<String, dynamic> json) {
  return TautulliActivity(
    streamCount: TautulliUtilities.ensureIntegerFromJson(json['stream_count']),
    streamCountDirectPlay: TautulliUtilities.ensureIntegerFromJson(
        json['stream_count_direct_play']),
    streamCountDirectStream: TautulliUtilities.ensureIntegerFromJson(
        json['stream_count_direct_stream']),
    streamCountTranscode:
        TautulliUtilities.ensureIntegerFromJson(json['stream_count_transcode']),
    totalBandwidth:
        TautulliUtilities.ensureIntegerFromJson(json['total_bandwidth']),
    lanBandwidth:
        TautulliUtilities.ensureIntegerFromJson(json['lan_bandwidth']),
    wanBandwidth:
        TautulliUtilities.ensureIntegerFromJson(json['wan_bandwidth']),
    sessions: TautulliActivity._sessionsFromJson(json['sessions'] as List),
  );
}

Map<String, dynamic> _$TautulliActivityToJson(TautulliActivity instance) =>
    <String, dynamic>{
      'sessions': TautulliActivity._sessionsToJson(instance.sessions),
      'stream_count': instance.streamCount,
      'stream_count_direct_play': instance.streamCountDirectPlay,
      'stream_count_direct_stream': instance.streamCountDirectStream,
      'stream_count_transcode': instance.streamCountTranscode,
      'total_bandwidth': instance.totalBandwidth,
      'lan_bandwidth': instance.lanBandwidth,
      'wan_bandwidth': instance.wanBandwidth,
    };
