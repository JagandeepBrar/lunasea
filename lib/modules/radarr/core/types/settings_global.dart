import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/modules/radarr.dart';

enum RadarrGlobalSettingsType {
  WEB_GUI,
  RUN_RSS_SYNC,
  SEARCH_ALL_MISSING,
  UPDATE_LIBRARY,
  BACKUP_DATABASE,
}

extension RadarrGlobalSettingsTypeExtension on RadarrGlobalSettingsType {
  IconData get icon {
    switch (this) {
      case RadarrGlobalSettingsType.WEB_GUI:
        return Icons.language_rounded;
      case RadarrGlobalSettingsType.UPDATE_LIBRARY:
        return Icons.autorenew_rounded;
      case RadarrGlobalSettingsType.RUN_RSS_SYNC:
        return Icons.rss_feed_rounded;
      case RadarrGlobalSettingsType.SEARCH_ALL_MISSING:
        return Icons.search_rounded;
      case RadarrGlobalSettingsType.BACKUP_DATABASE:
        return Icons.save_rounded;
    }
  }

  String get name {
    switch (this) {
      case RadarrGlobalSettingsType.WEB_GUI:
        return 'radarr.ViewWebGUI'.tr();
      case RadarrGlobalSettingsType.UPDATE_LIBRARY:
        return 'radarr.UpdateLibrary'.tr();
      case RadarrGlobalSettingsType.RUN_RSS_SYNC:
        return 'radarr.RunRSSSync'.tr();
      case RadarrGlobalSettingsType.SEARCH_ALL_MISSING:
        return 'radarr.SearchAllMissing'.tr();
      case RadarrGlobalSettingsType.BACKUP_DATABASE:
        return 'radarr.BackupDatabase'.tr();
    }
  }

  Future<void> execute(BuildContext context) async {
    switch (this) {
      case RadarrGlobalSettingsType.WEB_GUI:
        return _webGUI(context);
      case RadarrGlobalSettingsType.RUN_RSS_SYNC:
        return _runRssSync(context);
      case RadarrGlobalSettingsType.SEARCH_ALL_MISSING:
        return _searchAllMissing(context);
      case RadarrGlobalSettingsType.UPDATE_LIBRARY:
        return _updateLibrary(context);
      case RadarrGlobalSettingsType.BACKUP_DATABASE:
        return _backupDatabase(context);
    }
  }

  Future<void> _webGUI(BuildContext context) async {
    context.read<RadarrState>().host.openLink();
  }

  Future<void> _backupDatabase(BuildContext context) async {
    RadarrAPIHelper().backupDatabase(context: context);
  }

  Future<void> _searchAllMissing(BuildContext context) async {
    bool result = await RadarrDialogs().searchAllMissingMovies(context);
    if (result) RadarrAPIHelper().missingMovieSearch(context: context);
  }

  Future<void> _runRssSync(BuildContext context) async {
    RadarrAPIHelper().runRSSSync(context: context);
  }

  Future<void> _updateLibrary(BuildContext context) async {
    RadarrAPIHelper().updateLibrary(context: context);
  }
}
