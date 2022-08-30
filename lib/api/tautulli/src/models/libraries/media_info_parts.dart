import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'media_info_parts.g.dart';

/// Model to store the library content's media information for each part/file.
@JsonSerializable(explicitToJson: true)
class TautulliMediaInfoParts {
  /// The part ID.
  @JsonKey(name: 'id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? id;

  /// The path to the file on your system.
  @JsonKey(name: 'file', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? file;

  /// The size of the file, in bytes.
  @JsonKey(name: 'file_size', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? fileSize;

  /// Does the file have generated index files?
  @JsonKey(name: 'indexes', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? indexes;

  /// _Unknown_
  @JsonKey(name: 'selected', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? selected;

  @JsonKey(
      name: 'video_streams',
      toJson: _videoStreamToMap,
      fromJson: _videoStreamToObjectArray)
  final List<TautulliVideoStream>? videoStreams;

  @JsonKey(
      name: 'audio_streams',
      toJson: _audioStreamToMap,
      fromJson: _audioStreamToObjectArray)
  final List<TautulliAudioStream>? audioStreams;

  @JsonKey(
      name: 'subtitle_streams',
      toJson: _subtitleStreamToMap,
      fromJson: _subtitleStreamToObjectArray)
  final List<TautulliSubtitleStream>? subtitleStreams;

  TautulliMediaInfoParts({
    this.id,
    this.file,
    this.fileSize,
    this.indexes,
    this.selected,
    this.videoStreams,
    this.audioStreams,
    this.subtitleStreams,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /** GENERATOR TO/FROM JSON */

  /// Deserialize a JSON map to a [TautulliMediaInfoParts] object.
  factory TautulliMediaInfoParts.fromJsonGeneator(Map<String, dynamic> json) =>
      _$TautulliMediaInfoPartsFromJson(json);

  /// Serialize a [TautulliMediaInfoParts] object to a JSON map.
  Map<String, dynamic> toJsonGenerator() =>
      _$TautulliMediaInfoPartsToJson(this);

  /** MODIFIED TO/FROM JSON */

  /// Deserialize a JSON map to a [TautulliMediaInfoParts] object.
  factory TautulliMediaInfoParts.fromJson(Map<String, dynamic> json) =>
      TautulliMediaInfoParts(
        id: TautulliUtilities.ensureIntegerFromJson(json['id']),
        file: TautulliUtilities.ensureStringFromJson(json['file']),
        fileSize: TautulliUtilities.ensureIntegerFromJson(json['file_size']),
        indexes: TautulliUtilities.ensureBooleanFromJson(json['indexes']),
        selected: TautulliUtilities.ensureBooleanFromJson(json['selected']),
        videoStreams: TautulliMediaInfoParts._videoStreamToObjectArray(
            json['streams'] as List),
        audioStreams: TautulliMediaInfoParts._audioStreamToObjectArray(
            json['streams'] as List),
        subtitleStreams: TautulliMediaInfoParts._subtitleStreamToObjectArray(
            json['streams'] as List),
      );

  /// Serialize a [TautulliMediaInfoParts] object to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'file': this.file,
        'file_size': this.fileSize,
        'indexes': this.indexes,
        'selected': this.selected,
        'video_streams':
            TautulliMediaInfoParts._videoStreamToMap(this.videoStreams!),
        'audio_streams':
            TautulliMediaInfoParts._audioStreamToMap(this.audioStreams!),
        'subtitle_streams':
            TautulliMediaInfoParts._subtitleStreamToMap(this.subtitleStreams!),
      };

  static List<TautulliVideoStream> _videoStreamToObjectArray(
          List<dynamic> streams) =>
      streams
          .where((e) => e['type'] == '1')
          .map((stream) =>
              TautulliVideoStream.fromJson((stream as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _videoStreamToMap(
          List<TautulliVideoStream>? streams) =>
      streams?.map((stream) => stream.toJson()).toList();

  static List<TautulliAudioStream> _audioStreamToObjectArray(
          List<dynamic> streams) =>
      streams
          .where((e) => e['type'] == '2')
          .map((stream) =>
              TautulliAudioStream.fromJson((stream as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _audioStreamToMap(
          List<TautulliAudioStream>? streams) =>
      streams?.map((stream) => stream.toJson()).toList();

  static List<TautulliSubtitleStream> _subtitleStreamToObjectArray(
          List<dynamic> streams) =>
      streams
          .where((e) => e['type'] == '3')
          .map((stream) =>
              TautulliSubtitleStream.fromJson((stream as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _subtitleStreamToMap(
          List<TautulliSubtitleStream>? streams) =>
      streams?.map((stream) => stream.toJson()).toList();
}
