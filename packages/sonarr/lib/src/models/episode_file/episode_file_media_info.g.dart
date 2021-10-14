// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_file_media_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrEpisodeFileMediaInfo _$SonarrEpisodeFileMediaInfoFromJson(
        Map<String, dynamic> json) =>
    SonarrEpisodeFileMediaInfo(
      audioChannels: (json['audioChannels'] as num?)?.toDouble(),
      audioCodec: json['audioCodec'] as String?,
      videoCodec: json['videoCodec'] as String?,
    );

Map<String, dynamic> _$SonarrEpisodeFileMediaInfoToJson(
        SonarrEpisodeFileMediaInfo instance) =>
    <String, dynamic>{
      'audioChannels': instance.audioChannels,
      'audioCodec': instance.audioCodec,
      'videoCodec': instance.videoCodec,
    };
