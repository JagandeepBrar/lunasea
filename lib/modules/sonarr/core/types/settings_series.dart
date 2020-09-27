import 'package:flutter/material.dart';

enum SonarrSeriesSettingsType {
    EDIT,
    REFRESH,
    DELETE,
}

extension SonarrSeriesSettingsTypeExtension on SonarrSeriesSettingsType {
    IconData get icon {
        switch(this) {
            case SonarrSeriesSettingsType.EDIT: return Icons.edit;
            case SonarrSeriesSettingsType.REFRESH: return Icons.refresh;
            case SonarrSeriesSettingsType.DELETE: return Icons.delete;
        }
        throw Exception('Invalid SonarrSeriesSettingsType');
    }

    String get name {
        switch(this) {
            case SonarrSeriesSettingsType.EDIT: return 'Edit Series';
            case SonarrSeriesSettingsType.REFRESH: return 'Refresh Series';
            case SonarrSeriesSettingsType.DELETE: return 'Remove Series';
        }
        throw Exception('Invalid SonarrSeriesSettingsType');
    }
}
