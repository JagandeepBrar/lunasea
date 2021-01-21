import 'package:flutter/material.dart';

enum RadarrGlobalSettingsType {
    WEB_GUI,
    MANAGE_TAGS,
    VIEW_QUEUE,
    RUN_RSS_SYNC,
    SEARCH_ALL_MISSING,
    UPDATE_LIBRARY,
    BACKUP_DATABASE,
}

extension RadarrGlobalSettingsTypeExtension on RadarrGlobalSettingsType {
    IconData get icon {
        switch(this) {
            case RadarrGlobalSettingsType.WEB_GUI: return Icons.language;
            case RadarrGlobalSettingsType.VIEW_QUEUE: return Icons.queue;
            case RadarrGlobalSettingsType.MANAGE_TAGS: return Icons.style;
            case RadarrGlobalSettingsType.UPDATE_LIBRARY: return Icons.autorenew;
            case RadarrGlobalSettingsType.RUN_RSS_SYNC: return Icons.rss_feed;
            case RadarrGlobalSettingsType.SEARCH_ALL_MISSING: return Icons.search;
            case RadarrGlobalSettingsType.BACKUP_DATABASE: return Icons.save;
        }
        throw Exception('Invalid RadarrGlobalSettingsType');
    }

    String get name {
        switch(this) {
            case RadarrGlobalSettingsType.WEB_GUI: return 'View Web GUI';
            case RadarrGlobalSettingsType.VIEW_QUEUE: return 'View Queue';
            case RadarrGlobalSettingsType.MANAGE_TAGS: return 'Manage Tags';
            case RadarrGlobalSettingsType.UPDATE_LIBRARY: return 'Update Library';
            case RadarrGlobalSettingsType.RUN_RSS_SYNC: return 'Run RSS Sync';
            case RadarrGlobalSettingsType.SEARCH_ALL_MISSING: return 'Search All Missing';
            case RadarrGlobalSettingsType.BACKUP_DATABASE: return 'Backup Database';
        }
        throw Exception('Invalid RadarrGlobalSettingsType');
    }

    Future<void> execute(BuildContext context) async {
        // TODO
        switch(this) {
            case RadarrGlobalSettingsType.WEB_GUI: return;
            case RadarrGlobalSettingsType.MANAGE_TAGS: return;
            case RadarrGlobalSettingsType.VIEW_QUEUE: return;
            case RadarrGlobalSettingsType.RUN_RSS_SYNC: return;
            case RadarrGlobalSettingsType.SEARCH_ALL_MISSING: return;
            case RadarrGlobalSettingsType.UPDATE_LIBRARY: return;
            case RadarrGlobalSettingsType.BACKUP_DATABASE: return;
        }
        throw Exception('Invalid RadarrGlobalSettingsType');
    }
}
