import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/modules/sonarr.dart';

enum SonarrGlobalSettingsType {
  WEB_GUI,
  RUN_RSS_SYNC,
  SEARCH_ALL_MISSING,
  UPDATE_LIBRARY,
  BACKUP_DATABASE,
}

extension SonarrGlobalSettingsTypeExtension on SonarrGlobalSettingsType {
  IconData get icon {
    switch (this) {
      case SonarrGlobalSettingsType.WEB_GUI:
        return Icons.language_rounded;
      case SonarrGlobalSettingsType.UPDATE_LIBRARY:
        return Icons.autorenew_rounded;
      case SonarrGlobalSettingsType.RUN_RSS_SYNC:
        return Icons.rss_feed_rounded;
      case SonarrGlobalSettingsType.SEARCH_ALL_MISSING:
        return Icons.search_rounded;
      case SonarrGlobalSettingsType.BACKUP_DATABASE:
        return Icons.save_rounded;
    }
  }

  String get name {
    switch (this) {
      case SonarrGlobalSettingsType.WEB_GUI:
        return 'sonarr.ViewWebGUI'.tr();
      case SonarrGlobalSettingsType.UPDATE_LIBRARY:
        return 'sonarr.UpdateLibrary'.tr();
      case SonarrGlobalSettingsType.RUN_RSS_SYNC:
        return 'sonarr.RunRSSSync'.tr();
      case SonarrGlobalSettingsType.SEARCH_ALL_MISSING:
        return 'sonarr.SearchAllMissing'.tr();
      case SonarrGlobalSettingsType.BACKUP_DATABASE:
        return 'sonarr.BackupDatabase'.tr();
    }
  }

  Future<void> execute(BuildContext context) async {
    switch (this) {
      case SonarrGlobalSettingsType.WEB_GUI:
        return _webGUI(context);
      case SonarrGlobalSettingsType.RUN_RSS_SYNC:
        return _runRssSync(context);
      case SonarrGlobalSettingsType.SEARCH_ALL_MISSING:
        return _searchAllMissing(context);
      case SonarrGlobalSettingsType.UPDATE_LIBRARY:
        return _updateLibrary(context);
      case SonarrGlobalSettingsType.BACKUP_DATABASE:
        return _backupDatabase(context);
    }
  }

  Future<void> _webGUI(BuildContext context) async =>
      context.read<SonarrState>().host.openLink();
  Future<void> _backupDatabase(BuildContext context) async =>
      SonarrAPIController().backupDatabase(context: context);
  Future<void> _searchAllMissing(BuildContext context) async {
    bool result = await SonarrDialogs().searchAllMissingEpisodes(context);
    if (result) SonarrAPIController().missingEpisodesSearch(context: context);
  }

  Future<void> _runRssSync(BuildContext context) async =>
      SonarrAPIController().runRSSSync(context: context);
  Future<void> _updateLibrary(BuildContext context) async =>
      SonarrAPIController().updateLibrary(context: context);
}
