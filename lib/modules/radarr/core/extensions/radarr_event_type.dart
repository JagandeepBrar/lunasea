import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension lunaRadarrEventType on RadarrEventType {
    // Get LunaSea associated colour of the event type.
    Color get lunaColour {
        switch(this) {
            case RadarrEventType.GRABBED: return LunaColours.orange;
            case RadarrEventType.DOWNLOAD_FAILED: return LunaColours.red;
            case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED: return LunaColours.accent;
            case RadarrEventType.DOWNLOAD_IGNORED: return LunaColours.purple;
            case RadarrEventType.MOVIE_FILE_DELETED: return LunaColours.red;
            case RadarrEventType.MOVIE_FILE_RENAMED: return LunaColours.blue;
            case RadarrEventType.MOVIE_FOLDER_IMPORTED: return LunaColours.accent;
            default: return LunaColours.blueGrey;
        }
    }

    IconData get lunaIcon {
        switch(this) {    
            case RadarrEventType.GRABBED: return Icons.cloud_download;
            case RadarrEventType.DOWNLOAD_FAILED: return Icons.cloud_download;
            case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED: return Icons.download_rounded;
            case RadarrEventType.MOVIE_FOLDER_IMPORTED: return Icons.download_rounded;
            case RadarrEventType.MOVIE_FILE_DELETED: return Icons.delete;
            case RadarrEventType.DOWNLOAD_IGNORED: return Icons.cancel;
            case RadarrEventType.MOVIE_FILE_RENAMED: return Icons.drive_file_rename_outline;
            default: return Icons.help;
        }
    }

    Color get lunaIconColour {
        switch(this) {
            case RadarrEventType.GRABBED: return Colors.white;
            case RadarrEventType.DOWNLOAD_FAILED: return Colors.red;
            case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED: return Colors.white;
            case RadarrEventType.DOWNLOAD_IGNORED: return Colors.white;
            case RadarrEventType.MOVIE_FILE_DELETED: return Colors.white;
            case RadarrEventType.MOVIE_FILE_RENAMED: return Colors.white;
            case RadarrEventType.MOVIE_FOLDER_IMPORTED: return Colors.white;
            default: return Colors.white;
        }
    }

    String lunaReadable(RadarrHistoryRecord record) {
        switch(this) {
            case RadarrEventType.GRABBED: return 'Grabbed from ${record.data['indexer'] ?? Constants.TEXT_EMDASH}';
            case RadarrEventType.DOWNLOAD_FAILED: return 'Download Failed';
            case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED: return 'Movie Imported (${record?.quality?.quality?.name ?? Constants.TEXT_EMDASH})';
            case RadarrEventType.DOWNLOAD_IGNORED: return 'Download Ignored';
            case RadarrEventType.MOVIE_FILE_DELETED: return 'Movie File Deleted';
            case RadarrEventType.MOVIE_FILE_RENAMED: return 'Movie File Renamed';
            case RadarrEventType.MOVIE_FOLDER_IMPORTED: return 'Movie Imported (${record?.quality?.quality?.name ?? Constants.TEXT_EMDASH})';
        }
        return null;
    }

    List<Widget> lunaTableContent(RadarrHistoryRecord record, { bool movieHistory = false }) {
        switch(this) {
            case RadarrEventType.GRABBED: return _grabbedTableContent(record, !movieHistory);
            case RadarrEventType.DOWNLOAD_FAILED: return _downloadFailedTableContent(record, !movieHistory);
            case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED: return _downloadFolderImportedTableContent(record);
            case RadarrEventType.DOWNLOAD_IGNORED: return _downloadIgnoredTableContent(record, !movieHistory);
            case RadarrEventType.MOVIE_FILE_DELETED: return _movieFileDeletedTableContent(record, !movieHistory);
            case RadarrEventType.MOVIE_FILE_RENAMED: return _movieFileRenamedTableContent(record);
            case RadarrEventType.MOVIE_FOLDER_IMPORTED: return _movieFolderImportedTableContent(record);
            default: return [];
        }
    }

    List<Widget> _grabbedTableContent(RadarrHistoryRecord record, bool showSourceTitle) {
        return [
            if(showSourceTitle) LSTableContent(title: 'source title', body: record.sourceTitle ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'quality', body: record?.quality?.quality?.name ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'languages', body: record?.languages?.map<String>((language) => language.name)?.join('\n') ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'indexer', body: record.data['indexer'] ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'group', body: record.data['releaseGroup'] ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'client', body: record.data['downloadClientName'] ?? Constants.TEXT_EMDASH),
            LSTableContent(
                title: 'age',
                body: record.data['ageHours'] != null
                    ? double?.tryParse((record.data['ageHours'] as String))?.lunaHoursToAge() ?? Constants.TEXT_EMDASH
                    : Constants.TEXT_EMDASH,
            ),
            LSTableContent(
                title: 'published date',
                body: DateTime.tryParse(record.data['publishedDate']) != null
                    ? DateTime.tryParse(record.data['publishedDate'])?.lunaDateTimeReadable(timeOnNewLine: true) ?? Constants.TEXT_EMDASH
                    : Constants.TEXT_EMDASH,
            ),
            InkWell(
                child: LSTableContent(title: 'info url', body: record.data['nzbInfoUrl'] ?? Constants.TEXT_EMDASH),
                onTap: () async {
                    if(record.data['nzbInfoUrl'] != null) (record.data['nzbInfoUrl'] as String).lunaOpenGenericLink();
                },
            ),
        ];
    }

    List<Widget> _downloadFailedTableContent(RadarrHistoryRecord record, bool showSourceTitle) {
        return [
            if(showSourceTitle) LSTableContent(title: 'source title', body: record.sourceTitle ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'client', body: record.data['downloadClientName'] ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'message', body: record.data['message'] ?? Constants.TEXT_EMDASH),
        ];
    }

    List<Widget> _downloadFolderImportedTableContent(RadarrHistoryRecord record) {
        return [
            LSTableContent(title: 'quality', body: record?.quality?.quality?.name ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'languages', body: record?.languages?.map<String>((language) => language.name)?.join('\n') ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'client', body: record.data['downloadClientName'] ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'name', body: record.sourceTitle ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'source', body: record.data['droppedPath'] ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'imported to', body: record.data['importedPath'] ?? Constants.TEXT_EMDASH),
        ];
    }

    List<Widget> _downloadIgnoredTableContent(RadarrHistoryRecord record, bool showSourceTitle) {
        return [
            if(showSourceTitle) LSTableContent(title: 'source title', body: record.sourceTitle ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'message', body: record.data['message'] ?? Constants.TEXT_EMDASH),
        ];
    }

    List<Widget> _movieFileDeletedTableContent(RadarrHistoryRecord record, bool showSourceTitle) {
        return [
            if(showSourceTitle) LSTableContent(title: 'source title', body: record.sourceTitle ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'reason', body: record?.lunaFileDeletedReasonMessage ?? Constants.TEXT_EMDASH),
        ];
    }

    List<Widget> _movieFileRenamedTableContent(RadarrHistoryRecord record) {
        return [
            LSTableContent(title: 'source', body: record.data['sourceRelativePath'] ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'destination', body: record.data['relativePath'] ?? Constants.TEXT_EMDASH),
        ];
    }

    List<Widget> _movieFolderImportedTableContent(RadarrHistoryRecord record) {
        return [
            LSTableContent(title: 'quality', body: record?.quality?.quality?.name ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'languages', body: record?.languages?.map<String>((language) => language.name)?.join('\n') ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'client', body: record.data['downloadClientName'] ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'name', body: record.sourceTitle ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'source', body: record.data['droppedPath'] ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'imported to', body: record.data['importedPath'] ?? Constants.TEXT_EMDASH),
        ];
    }
}
