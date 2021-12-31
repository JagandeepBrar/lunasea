import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrImportMode on RadarrImportMode {
  String get lunaReadable {
    switch (this) {
      case RadarrImportMode.COPY:
        return 'radarr.CopyFull'.tr();
      case RadarrImportMode.MOVE:
        return 'radarr.MoveFull'.tr();
    }
  }

  IconData get lunaIcon {
    switch (this) {
      case RadarrImportMode.COPY:
        return Icons.copy_rounded;
      case RadarrImportMode.MOVE:
        return Icons.drive_file_move_outline;
    }
  }
}
