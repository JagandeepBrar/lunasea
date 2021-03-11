import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'log_type.g.dart';

@HiveType(typeId: 24, adapterName: 'LunaLogTypeAdapter')
enum LunaLogType {
    @HiveField(0)
    WARNING,
    @HiveField(1)
    ERROR,
    @HiveField(2)
    CRITICAL,
}

extension LunaLogTypeExtension on LunaLogType {
    LunaLogType fromKey(String key) {
        switch(key) {
            case 'warning': return LunaLogType.WARNING;
            case 'error': return LunaLogType.ERROR;
            case 'critical': return LunaLogType.CRITICAL;
        }
        return null;
    }

    String get key {
        switch(this) {
            case LunaLogType.WARNING: return 'warning';
            case LunaLogType.ERROR: return 'error';
            case LunaLogType.CRITICAL: return 'critical';
        }
        throw Exception('Invalid LunaLogType');
    }

    String get name {
        switch(this) {
            case LunaLogType.WARNING: return 'Warning';
            case LunaLogType.ERROR: return 'Error';
            case LunaLogType.CRITICAL: return 'Critical';
        }
        throw Exception('Invalid LunaLogType');
    }

    String get description => 'View $name Logs';

    IconData get icon {
        switch(this) {
            case LunaLogType.WARNING: return Icons.warning;
            case LunaLogType.ERROR: return Icons.report_rounded;
            case LunaLogType.CRITICAL: return Icons.new_releases;
        }
        throw Exception('Invalid LunaLogType');
    }

    Color get color {
        switch(this) {
            case LunaLogType.WARNING: return LunaColours.orange;
            case LunaLogType.ERROR: return LunaColours.red;
            case LunaLogType.CRITICAL: return LunaColours.accent;
        }
        throw Exception('Invalid LunaLogType');
    }
}
