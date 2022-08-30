import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/modules/tautulli.dart';

enum TautulliGlobalSettingsType {
  WEB_GUI,
  BACKUP_CONFIG,
  BACKUP_DB,
  DELETE_CACHE,
  DELETE_IMAGE_CACHE,
  DELETE_TEMP_SESSIONS,
}

extension TautulliGlobalSettingsTypeExtension on TautulliGlobalSettingsType {
  IconData get icon {
    switch (this) {
      case TautulliGlobalSettingsType.WEB_GUI:
        return Icons.language_rounded;
      case TautulliGlobalSettingsType.BACKUP_CONFIG:
        return Icons.note_rounded;
      case TautulliGlobalSettingsType.BACKUP_DB:
        return Icons.save_rounded;
      case TautulliGlobalSettingsType.DELETE_CACHE:
        return Icons.cached_rounded;
      case TautulliGlobalSettingsType.DELETE_IMAGE_CACHE:
        return Icons.image_rounded;
      case TautulliGlobalSettingsType.DELETE_TEMP_SESSIONS:
        return Icons.delete_sweep_rounded;
    }
  }

  String get name {
    switch (this) {
      case TautulliGlobalSettingsType.BACKUP_CONFIG:
        return 'tautulli.BackupConfiguration'.tr();
      case TautulliGlobalSettingsType.BACKUP_DB:
        return 'tautulli.BackupDatabase'.tr();
      case TautulliGlobalSettingsType.WEB_GUI:
        return 'tautulli.ViewWebGUI'.tr();
      case TautulliGlobalSettingsType.DELETE_CACHE:
        return 'tautulli.DeleteCache'.tr();
      case TautulliGlobalSettingsType.DELETE_IMAGE_CACHE:
        return 'tautulli.DeleteImageCache'.tr();
      case TautulliGlobalSettingsType.DELETE_TEMP_SESSIONS:
        return 'tautulli.DeleteTemporarySessions'.tr();
    }
  }

  Future<void> execute(BuildContext context) async {
    switch (this) {
      case TautulliGlobalSettingsType.WEB_GUI:
        return _webGUI(context);
      case TautulliGlobalSettingsType.BACKUP_CONFIG:
        return _backupConfig(context);
      case TautulliGlobalSettingsType.BACKUP_DB:
        return _backupDatabase(context);
      case TautulliGlobalSettingsType.DELETE_CACHE:
        return _deleteCache(context);
      case TautulliGlobalSettingsType.DELETE_IMAGE_CACHE:
        return _deleteImageCache(context);
      case TautulliGlobalSettingsType.DELETE_TEMP_SESSIONS:
        return _deleteTemporarySessions(context);
    }
  }

  Future<void> _webGUI(BuildContext context) async =>
      context.read<TautulliState>().host.openLink();
  Future<void> _backupConfig(BuildContext context) async =>
      TautulliAPIHelper().backupConfiguration(context: context);
  Future<void> _backupDatabase(BuildContext context) async =>
      TautulliAPIHelper().backupDatabase(context: context);
  Future<void> _deleteCache(BuildContext context) async =>
      TautulliAPIHelper().deleteCache(context: context);
  Future<void> _deleteImageCache(BuildContext context) async =>
      TautulliAPIHelper().deleteImageCache(context: context);
  Future<void> _deleteTemporarySessions(BuildContext context) async =>
      TautulliAPIHelper().deleteTemporarySessions(context: context);
}
