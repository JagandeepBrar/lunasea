import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
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
        switch(this) {
            case TautulliGlobalSettingsType.WEB_GUI: return Icons.language;
            case TautulliGlobalSettingsType.BACKUP_CONFIG: return Icons.note;
            case TautulliGlobalSettingsType.BACKUP_DB: return Icons.save;
            case TautulliGlobalSettingsType.DELETE_CACHE: return Icons.cached;
            case TautulliGlobalSettingsType.DELETE_IMAGE_CACHE: return Icons.image;
            case TautulliGlobalSettingsType.DELETE_TEMP_SESSIONS: return Icons.delete_sweep;
        }
        throw Exception('Invalid TautulliGlobalSettingsType');
    }

    String get name {
        switch(this) {
            case TautulliGlobalSettingsType.BACKUP_CONFIG: return 'Backup Configuration';
            case TautulliGlobalSettingsType.BACKUP_DB: return 'Backup Database';
            case TautulliGlobalSettingsType.WEB_GUI: return 'View Web GUI';
            case TautulliGlobalSettingsType.DELETE_CACHE: return 'Delete Cache';
            case TautulliGlobalSettingsType.DELETE_IMAGE_CACHE: return 'Delete Image Cache';
            case TautulliGlobalSettingsType.DELETE_TEMP_SESSIONS: return 'Delete Temp Sessions';
        }
        throw Exception('Invalid TautulliGlobalSettingsType');
    }

    Future<void> execute(BuildContext context) async {
        switch(this) {
            case TautulliGlobalSettingsType.WEB_GUI: return _webGUI(context);
            case TautulliGlobalSettingsType.BACKUP_CONFIG: return _backupConfig(context);
            case TautulliGlobalSettingsType.BACKUP_DB: return _backupDatabase(context);
            case TautulliGlobalSettingsType.DELETE_CACHE: return _deleteCache(context);
            case TautulliGlobalSettingsType.DELETE_IMAGE_CACHE: return _deleteImageCache(context);
            case TautulliGlobalSettingsType.DELETE_TEMP_SESSIONS: return _deleteTemporarySessions(context);
        }
        throw Exception('Invalid TautulliGlobalSettingsType');
    }

    Future<void> _webGUI(BuildContext context) async => context.read<TautulliState>().host.lunaOpenGenericLink();
    Future<void> _backupConfig(BuildContext context) async => TautulliAPIHelper().backupConfiguration(context: context);
    Future<void> _backupDatabase(BuildContext context) async => TautulliAPIHelper().backupDatabase(context: context);
    Future<void> _deleteCache(BuildContext context) async => TautulliAPIHelper().deleteCache(context: context);
    Future<void> _deleteImageCache(BuildContext context) async => TautulliAPIHelper().deleteImageCache(context: context);
    Future<void> _deleteTemporarySessions(BuildContext context) async => TautulliAPIHelper().deleteTemporarySessions(context: context);
}
