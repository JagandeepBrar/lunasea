import 'package:flutter/material.dart';

enum SonarrGlobalSettingsType {
  WEB_GUI,
  MANAGE_TAGS,
  VIEW_QUEUE,
  RUN_RSS_SYNC,
  SEARCH_ALL_MISSING,
  UPDATE_LIBRARY,
  BACKUP_DATABASE,
}

extension SonarrGlobalSettingsTypeExtension on SonarrGlobalSettingsType {
  IconData get icon {
    switch (this) {
      case SonarrGlobalSettingsType.WEB_GUI:
        return Icons.language;
      case SonarrGlobalSettingsType.VIEW_QUEUE:
        return Icons.queue;
      case SonarrGlobalSettingsType.MANAGE_TAGS:
        return Icons.style;
      case SonarrGlobalSettingsType.UPDATE_LIBRARY:
        return Icons.autorenew;
      case SonarrGlobalSettingsType.RUN_RSS_SYNC:
        return Icons.rss_feed;
      case SonarrGlobalSettingsType.SEARCH_ALL_MISSING:
        return Icons.search;
      case SonarrGlobalSettingsType.BACKUP_DATABASE:
        return Icons.save;
    }
    throw Exception('Invalid SonarrGlobalSettingsType');
  }

  String get name {
    switch (this) {
      case SonarrGlobalSettingsType.WEB_GUI:
        return 'View Web GUI';
      case SonarrGlobalSettingsType.VIEW_QUEUE:
        return 'View Queue';
      case SonarrGlobalSettingsType.MANAGE_TAGS:
        return 'Manage Tags';
      case SonarrGlobalSettingsType.UPDATE_LIBRARY:
        return 'Update Library';
      case SonarrGlobalSettingsType.RUN_RSS_SYNC:
        return 'Run RSS Sync';
      case SonarrGlobalSettingsType.SEARCH_ALL_MISSING:
        return 'Search All Missing';
      case SonarrGlobalSettingsType.BACKUP_DATABASE:
        return 'Backup Database';
    }
    throw Exception('Invalid SonarrGlobalSettingsType');
  }

  Future<void> execute(BuildContext context) async {
    // TODO: Execute actions
    return;
  }
}
