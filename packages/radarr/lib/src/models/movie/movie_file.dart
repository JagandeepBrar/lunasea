import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import '../../../models.dart';
import '../../../utilities.dart';

part 'movie_file.g.dart';

/// Model for a movies' file information
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrMovieFile {
    @JsonKey(name: 'movieId')
    int? movieId;

    @JsonKey(name: 'relativePath')
    String? relativePath;
    
    @JsonKey(name: 'path')
    String? path;

    @JsonKey(name: 'size')
    int? size;

    @JsonKey(name: 'dateAdded', toJson: RadarrUtilities.dateTimeToJson, fromJson: RadarrUtilities.dateTimeFromJson)
    DateTime? dateAdded;

    @JsonKey(name: 'quality')
    RadarrMovieFileQuality? quality;

    @JsonKey(name: 'customFormats')
    List<RadarrCustomFormat>? customFormats;

    @JsonKey(name: 'mediaInfo')
    RadarrMovieFileMediaInfo? mediaInfo;

    @JsonKey(name: 'qualityCutoffNotMet')
    bool? qualityCutoffNotMet;

    @JsonKey(name: 'languages')
    List<RadarrLanguage>? languages;

    @JsonKey(name: 'edition')
    String? edition;

    @JsonKey(name: 'id')
    int? id;

    RadarrMovieFile({
        this.movieId,
        this.relativePath,
        this.path,
        this.size,
        this.dateAdded,
        this.quality,
        this.customFormats,
        this.mediaInfo,
        this.qualityCutoffNotMet,
        this.languages,
        this.edition,
        this.id,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [RadarrMovieFile] object.
    factory RadarrMovieFile.fromJson(Map<String, dynamic> json) => _$RadarrMovieFileFromJson(json);
    /// Serialize a [RadarrMovieFile] object to a JSON map.
    Map<String, dynamic> toJson() => _$RadarrMovieFileToJson(this);
}
