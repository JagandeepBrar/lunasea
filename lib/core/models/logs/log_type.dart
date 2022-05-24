import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system/flavor.dart';

part 'log_type.g.dart';

@HiveType(typeId: 24, adapterName: 'LunaLogTypeAdapter')
enum LunaLogType {
  @HiveField(0)
  WARNING,
  @HiveField(1)
  ERROR,
  @HiveField(2)
  CRITICAL,
  @HiveField(3)
  DEBUG,
}

extension LunaLogTypeExtension on LunaLogType {
  LunaLogType? fromKey(String key) {
    switch (key) {
      case 'warning':
        return LunaLogType.WARNING;
      case 'error':
        return LunaLogType.ERROR;
      case 'critical':
        return LunaLogType.CRITICAL;
      case 'debug':
        return LunaLogType.DEBUG;
    }
    return null;
  }

  String get key {
    switch (this) {
      case LunaLogType.WARNING:
        return 'warning';
      case LunaLogType.ERROR:
        return 'error';
      case LunaLogType.CRITICAL:
        return 'critical';
      case LunaLogType.DEBUG:
        return 'debug';
    }
  }

  bool get enabled {
    switch (this) {
      case LunaLogType.WARNING:
        return true;
      case LunaLogType.ERROR:
        return true;
      case LunaLogType.CRITICAL:
        return true;
      case LunaLogType.DEBUG:
        return LunaFlavor.CANDIDATE.isRunningFlavor();
    }
  }

  String get name {
    switch (this) {
      case LunaLogType.WARNING:
        return 'Warning';
      case LunaLogType.ERROR:
        return 'Error';
      case LunaLogType.CRITICAL:
        return 'Critical';
      case LunaLogType.DEBUG:
        return 'Debug';
    }
  }

  String get description => 'View $name Logs';

  IconData get icon {
    switch (this) {
      case LunaLogType.WARNING:
        return LunaIcons.WARNING;
      case LunaLogType.ERROR:
        return Icons.report_rounded;
      case LunaLogType.CRITICAL:
        return Icons.new_releases_rounded;
      case LunaLogType.DEBUG:
        return Icons.bug_report_rounded;
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
}
