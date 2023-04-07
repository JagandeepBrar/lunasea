import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system/flavor.dart';

part 'log_type.g.dart';

const TYPE_DEBUG = 'debug';
const TYPE_WARNING = 'warning';
const TYPE_ERROR = 'error';
const TYPE_CRITICAL = 'critical';

@HiveType(typeId: 24, adapterName: 'LunaLogTypeAdapter')
enum LunaLogType {
  @HiveField(0)
  WARNING(TYPE_WARNING),
  @HiveField(1)
  ERROR(TYPE_ERROR),
  @HiveField(2)
  CRITICAL(TYPE_CRITICAL),
  @HiveField(3)
  DEBUG(TYPE_DEBUG);

  final String key;
  const LunaLogType(this.key);

  String get description => 'settings.ViewTypeLogs'.tr(args: [title]);

  bool get enabled {
    switch (this) {
      case LunaLogType.DEBUG:
        return LunaFlavor.BETA.isRunningFlavor();
      default:
        return true;
    }
  }

  String get title {
    switch (this) {
      case LunaLogType.WARNING:
        return 'lunasea.Warning'.tr();
      case LunaLogType.ERROR:
        return 'lunasea.Error'.tr();
      case LunaLogType.CRITICAL:
        return 'lunasea.Critical'.tr();
      case LunaLogType.DEBUG:
        return 'lunasea.Debug'.tr();
    }
  }

  IconData get icon {
    switch (this) {
      case LunaLogType.WARNING:
        return LunaIcons.WARNING;
      case LunaLogType.ERROR:
        return LunaIcons.ERROR;
      case LunaLogType.CRITICAL:
        return LunaIcons.CRITICAL;
      case LunaLogType.DEBUG:
        return LunaIcons.DEBUG;
    }
  }

  Color get color {
    switch (this) {
      case LunaLogType.WARNING:
        return LunaColours.orange;
      case LunaLogType.ERROR:
        return LunaColours.red;
      case LunaLogType.CRITICAL:
        return LunaColours.accent;
      case LunaLogType.DEBUG:
        return LunaColours.blueGrey;
    }
  }

  static LunaLogType? fromKey(String key) {
    switch (key) {
      case TYPE_WARNING:
        return LunaLogType.WARNING;
      case TYPE_ERROR:
        return LunaLogType.ERROR;
      case TYPE_CRITICAL:
        return LunaLogType.CRITICAL;
      case TYPE_DEBUG:
        return LunaLogType.DEBUG;
    }
    return null;
  }
}
