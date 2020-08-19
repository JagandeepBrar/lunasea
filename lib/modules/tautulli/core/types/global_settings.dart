import 'package:flutter/material.dart';

enum TautulliGlobalSettings {
    WEB_GUI,
    BACKUP_CONFIG,
    BACKUP_DB,
}

extension TautulliGlobalSettingsExtension on TautulliGlobalSettings {
    IconData get icon {
        switch(this) {
            case TautulliGlobalSettings.WEB_GUI: return Icons.language;
            case TautulliGlobalSettings.BACKUP_CONFIG: return Icons.settings_backup_restore;
            case TautulliGlobalSettings.BACKUP_DB: return Icons.save;
        }
        throw Exception('Invalid TautulliGlobalSettings');
    }

    String get name {
        switch(this) {
            case TautulliGlobalSettings.BACKUP_CONFIG: return 'Backup Configuration';
            case TautulliGlobalSettings.BACKUP_DB: return 'Backup Database';
            case TautulliGlobalSettings.WEB_GUI: return 'View Web GUI';
        }
        throw Exception('Invalid TautulliGlobalSettings');
    }
}
