import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

enum ReadarrGlobalSettingsType {
  WEB_GUI,
  RUN_RSS_SYNC,
  SEARCH_ALL_MISSING,
  UPDATE_LIBRARY,
  BACKUP_DATABASE,
}

extension ReadarrGlobalSettingsTypeExtension on ReadarrGlobalSettingsType {
  IconData get icon {
    switch (this) {
      case ReadarrGlobalSettingsType.WEB_GUI:
        return Icons.language_rounded;
      case ReadarrGlobalSettingsType.UPDATE_LIBRARY:
        return Icons.autorenew_rounded;
      case ReadarrGlobalSettingsType.RUN_RSS_SYNC:
        return Icons.rss_feed_rounded;
      case ReadarrGlobalSettingsType.SEARCH_ALL_MISSING:
        return Icons.search_rounded;
      case ReadarrGlobalSettingsType.BACKUP_DATABASE:
        return Icons.save_rounded;
    }
  }

  String get name {
    switch (this) {
      case ReadarrGlobalSettingsType.WEB_GUI:
        return 'readarr.ViewWebGUI'.tr();
      case ReadarrGlobalSettingsType.UPDATE_LIBRARY:
        return 'readarr.UpdateLibrary'.tr();
      case ReadarrGlobalSettingsType.RUN_RSS_SYNC:
        return 'readarr.RunRSSSync'.tr();
      case ReadarrGlobalSettingsType.SEARCH_ALL_MISSING:
        return 'readarr.SearchAllMissing'.tr();
      case ReadarrGlobalSettingsType.BACKUP_DATABASE:
        return 'readarr.BackupDatabase'.tr();
    }
  }

  Future<void> execute(BuildContext context) async {
    switch (this) {
      case ReadarrGlobalSettingsType.WEB_GUI:
        return _webGUI(context);
      case ReadarrGlobalSettingsType.RUN_RSS_SYNC:
        return _runRssSync(context);
      case ReadarrGlobalSettingsType.SEARCH_ALL_MISSING:
        return _searchAllMissing(context);
      case ReadarrGlobalSettingsType.UPDATE_LIBRARY:
        return _updateLibrary(context);
      case ReadarrGlobalSettingsType.BACKUP_DATABASE:
        return _backupDatabase(context);
    }
  }

  Future<void> _webGUI(BuildContext context) async =>
      context.read<ReadarrState>().host.lunaOpenGenericLink(
            headers: context.read<ReadarrState>().headers,
          );
  Future<void> _backupDatabase(BuildContext context) async =>
      ReadarrAPIController().backupDatabase(context: context);
  Future<void> _searchAllMissing(BuildContext context) async {
    bool result = await ReadarrDialogs().searchAllMissingEpisodes(context);
    if (result) ReadarrAPIController().missingBooksSearch(context: context);
  }

  Future<void> _runRssSync(BuildContext context) async =>
      ReadarrAPIController().runRSSSync(context: context);
  Future<void> _updateLibrary(BuildContext context) async =>
      ReadarrAPIController().updateLibrary(context: context);
}
