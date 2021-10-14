import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'history_record_data.g.dart';

/// Model to store an individual history record's event data from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrHistoryRecordData {
    /// Original folder of the file
    /// 
    /// Found in event type(s):
    /// - downloadFolderImported
    @JsonKey(name: 'droppedPath')
    String? droppedPath;

    /// Path once the file was imported
    /// 
    /// Found in event type(s):
    /// - downloadFolderImported
    @JsonKey(name: 'importedPath')
    String? importedPath;

    /// Download client where the file was downloaded
    /// 
    /// Found in event type(s):
    /// - downloadFolderImported
    /// - grabbed
    @JsonKey(name: 'downloadClient')
    String? downloadClient;

    /// Name of the download client
    /// 
    /// Found in event type(s):
    /// - downloadFolderImported
    /// - grabbed
    @JsonKey(name: 'downloadClientName')
    String? downloadClientName;

    /// Originating indexer
    /// 
    /// Found in event type(s):
    /// - grabbed
    @JsonKey(name: 'indexer')
    String? indexer;

    /// NZB info URL
    /// 
    /// Found in event type(s):
    /// - grabbed
    @JsonKey(name: 'nzbInfoUrl')
    String? nzbInfoUrl;

    /// Release group of the episode
    /// 
    /// Found in event type(s):
    /// - grabbed
    @JsonKey(name: 'releaseGroup')
    String? releaseGroup;

    /// NZB download URL
    /// 
    /// Found in event type(s):
    /// - grabbed
    @JsonKey(name: 'downloadUrl')
    String? downloadUrl;

    /// Release GUID
    /// 
    /// Found in event type(s):
    /// - grabbed
    @JsonKey(name: 'guid')
    String? guid;

    /// Reason for the event
    /// 
    /// Found in event type(s):
    /// - episodeFileDeleted
    @JsonKey(name: 'reason')
    String? reason;

    /// The message (typically from the download client)
    /// 
    /// Found in the event type(s):
    /// - downloadFailed
    @JsonKey(name: 'message')
    String? message;

    /// Source file full path
    /// 
    /// Found in the event type(s):
    /// - episodeFileRenamed
    @JsonKey(name: 'sourcePath')
    String? sourcePath;

    /// Source file relative path to the series' root folder
    /// 
    /// Found in the event type(s):
    /// - episodeFileRenamed
    @JsonKey(name: 'sourceRelativePath')
    String? sourceRelativePath;

    /// File's new full path
    /// 
    /// Found in the event type(s):
    /// - episodeFileRenamed
    @JsonKey(name: 'path')
    String? path;

    /// File's new relative path to the series' root folder
    /// 
    /// Found in the event type(s):
    /// - episodeFileRenamed
    @JsonKey(name: 'relativePath')
    String? relativePath;

    SonarrHistoryRecordData({
        this.droppedPath,
        this.importedPath,
        this.downloadClient,
        this.downloadClientName,
        this.indexer,
        this.nzbInfoUrl,
        this.releaseGroup,
        this.downloadUrl,
        this.guid,
        this.reason,
        this.message,
        this.sourcePath,
        this.sourceRelativePath,
        this.path,
        this.relativePath,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrHistoryRecordData] object.
    factory SonarrHistoryRecordData.fromJson(Map<String, dynamic> json) => _$SonarrHistoryRecordDataFromJson(json);
    /// Serialize a [SonarrHistoryRecordData] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrHistoryRecordDataToJson(this);
}
