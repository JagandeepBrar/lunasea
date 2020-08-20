import 'package:flutter/material.dart';

enum TautulliGlobalSettingsType {
    WEB_GUI,
    BACKUP_CONFIG,
    BACKUP_DB,
}

extension TautulliGlobalSettingsTypeExtension on TautulliGlobalSettingsType {
    IconData get icon {
        switch(this) {
            case TautulliGlobalSettingsType.WEB_GUI: return Icons.language;
            case TautulliGlobalSettingsType.BACKUP_CONFIG: return Icons.settings_backup_restore;
            case TautulliGlobalSettingsType.BACKUP_DB: return Icons.save;
        }
        throw Exception('Invalid TautulliGlobalSettingsType');
    }

    String get name {
        switch(this) {
            case TautulliGlobalSettingsType.BACKUP_CONFIG: return 'Backup Configuration';
            case TautulliGlobalSettingsType.BACKUP_DB: return 'Backup Database';
            case TautulliGlobalSettingsType.WEB_GUI: return 'View Web GUI';
        }
        throw Exception('Invalid TautulliGlobalSettingsType');
    }
}
