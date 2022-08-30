import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'episode_file_media_info.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrEpisodeFileMediaInfo {
  @JsonKey(name: 'audioBitrate')
  int? audioBitrate;

  @JsonKey(name: 'audioChannels')
  double? audioChannels;

  @JsonKey(name: 'audioCodec')
  String? audioCodec;

  @JsonKey(name: 'audioLanguages')
  String? audioLanguages;

  @JsonKey(name: 'audioStreamCount')
  int? audioStreamCount;

  @JsonKey(name: 'videoBitDepth')
  int? videoBitDepth;

  @JsonKey(name: 'videoBitrate')
  int? videoBitrate;

  @JsonKey(name: 'videoCodec')
  String? videoCodec;

  @JsonKey(name: 'videoFps')
  double? videoFps;

  @JsonKey(name: 'resolution')
  String? resolution;

  @JsonKey(name: 'runTime')
  String? runTime;

  @JsonKey(name: 'scanType')
  String? scanType;

  @JsonKey(name: 'subtitles')
  String? subtitles;

  SonarrEpisodeFileMediaInfo({
    this.audioBitrate,
    this.audioChannels,
    this.audioCodec,
    this.audioLanguages,
    this.audioStreamCount,
    this.videoBitDepth,
    this.videoBitrate,
    this.videoCodec,
    this.videoFps,
    this.resolution,
    this.runTime,
    this.scanType,
    this.subtitles,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrEpisodeFileMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$SonarrEpisodeFileMediaInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrEpisodeFileMediaInfoToJson(this);
}
