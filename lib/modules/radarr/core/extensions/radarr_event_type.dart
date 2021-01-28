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

    List<Widget> lunaTableContent(RadarrHistoryRecord record) {
        switch(this) {
            case RadarrEventType.GRABBED: return _grabbedTableContent(record);
            case RadarrEventType.DOWNLOAD_FAILED: return _downloadFailedTableContent(record);
            case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED: return _downloadFolderImportedTableContent(record);
            case RadarrEventType.DOWNLOAD_IGNORED: return _downloadIgnoredTableContent(record);
            case RadarrEventType.MOVIE_FILE_DELETED: return _movieFileDeletedTableContent(record);
            case RadarrEventType.MOVIE_FILE_RENAMED: return _movieFileRenamedTableContent(record);
            case RadarrEventType.MOVIE_FOLDER_IMPORTED: return _movieFolderImportedTableContent(record);
            default: return [];
        }
    }

    List<Widget> _grabbedTableContent(RadarrHistoryRecord record) {
        return [];
    }

    List<Widget> _downloadFailedTableContent(RadarrHistoryRecord record) {
        return [];
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

    List<Widget> _downloadIgnoredTableContent(RadarrHistoryRecord record) {
        // TODO
        return [];
    }

    List<Widget> _movieFileDeletedTableContent(RadarrHistoryRecord record) {
        // TODO
        return [];
    }

    List<Widget> _movieFileRenamedTableContent(RadarrHistoryRecord record) {
        // TODO
        return [];
    }

    List<Widget> _movieFolderImportedTableContent(RadarrHistoryRecord record) {
        // TODO
        return [];
    }
}
