import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

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
        switch(this) {
            case RadarrGlobalSettingsType.WEB_GUI: return _webGUI(context);
            case RadarrGlobalSettingsType.MANAGE_TAGS: return _manageTags(context);
            case RadarrGlobalSettingsType.VIEW_QUEUE: return _viewQueue(context);
            case RadarrGlobalSettingsType.RUN_RSS_SYNC: return _runRssSync(context);
            case RadarrGlobalSettingsType.SEARCH_ALL_MISSING: return _searchAllMissing(context);
            case RadarrGlobalSettingsType.UPDATE_LIBRARY: return _updateLibrary(context);
            case RadarrGlobalSettingsType.BACKUP_DATABASE: return _backupDatabase(context);
        }
        throw Exception('Invalid RadarrGlobalSettingsType');
    }
    
    Future<void> _webGUI(BuildContext context) async => Provider.of<RadarrState>(context, listen: false).host.lunaOpenGenericLink();
    Future<void> _viewQueue(BuildContext context) async => RadarrQueueRouter().navigateTo(context);
    Future<void> _manageTags(BuildContext context) async => RadarrTagsRouter().navigateTo(context);
    Future<void> _backupDatabase(BuildContext context) async => RadarrAPIHelper().backupDatabase(context: context);
    Future<void> _searchAllMissing(BuildContext context) async => RadarrAPIHelper().missingMovieSearch(context: context);
    Future<void> _runRssSync(BuildContext context) async => RadarrAPIHelper().runRSSSync(context: context);
    Future<void> _updateLibrary(BuildContext context) async => RadarrAPIHelper().updateLibrary(context: context);
}
