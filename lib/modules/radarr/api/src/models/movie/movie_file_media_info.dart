import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'movie_file_media_info.g.dart';

@JsonSerializable()
class RadarrMovieFileMediaInfo {
  @JsonKey()
  int? audioBitrate;

  @JsonKey()
  double? audioChannels;

  @JsonKey()
  String? audioCodec;

  @JsonKey()
  String? audioLanguages;

  @JsonKey()
  int? audioStreamCount;

  @JsonKey()
  int? videoBitDepth;

  @JsonKey()
  int? videoBitrate;

  @JsonKey()
  String? videoCodec;

  @JsonKey()
  String? videoDynamicRangeType;

  @JsonKey()
  double? videoFps;

  @JsonKey()
  String? resolution;

  @JsonKey()
  String? runTime;

  @JsonKey()
  String? scanType;

  @JsonKey()
  String? subtitles;

  RadarrMovieFileMediaInfo({
    this.audioBitrate,
    this.audioChannels,
    this.audioCodec,
    this.audioLanguages,
    this.audioStreamCount,
    this.videoBitDepth,
    this.videoBitrate,
    this.videoCodec,
    this.videoDynamicRangeType,
    this.videoFps,
    this.resolution,
    this.runTime,
    this.scanType,
    this.subtitles,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrMovieFileMediaInfo] object.
  factory RadarrMovieFileMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$RadarrMovieFileMediaInfoFromJson(json);

  /// Serialize a [RadarrMovieFileMediaInfo] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrMovieFileMediaInfoToJson(this);
}
