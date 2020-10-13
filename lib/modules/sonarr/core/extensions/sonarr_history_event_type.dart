import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

extension SonarrHistoryEventTypeLunaExtension on SonarrHistoryEventType {
    String lunaMessage(SonarrHistoryRecord data) {
        switch(this) {
            case SonarrHistoryEventType.EPISODE_FILE_RENAMED: return 'Episode File Renamed';
            case SonarrHistoryEventType.EPISODE_FILE_DELETED: return 'Episode File Deleted (${data.data.reason})';
            case SonarrHistoryEventType.DOWNLOAD_FOLDER_IMPORTED: return 'Imported Episode File (${data?.quality?.quality?.name ?? 'Unknown'})';
            case SonarrHistoryEventType.DOWNLOAD_FAILED: return 'Download Failed';
            case SonarrHistoryEventType.GRABBED: return 'Grabbed From ${data.data.indexer}';
        }
        return 'Unknown Event';
    }

    Color get lunaColour {
        switch(this) { 
            case SonarrHistoryEventType.EPISODE_FILE_RENAMED: return LunaColours.blue;
            case SonarrHistoryEventType.EPISODE_FILE_DELETED: return LunaColours.red;
            case SonarrHistoryEventType.DOWNLOAD_FOLDER_IMPORTED: return LunaColours.accent;
            case SonarrHistoryEventType.DOWNLOAD_FAILED: return LunaColours.red;
            case SonarrHistoryEventType.GRABBED: return LunaColours.orange;
        }
        return LunaColours.blueGrey;
    }
}
