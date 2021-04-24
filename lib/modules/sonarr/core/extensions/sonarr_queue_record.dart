import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

extension SonarrQueueRecordExtension on SonarrQueueRecord {
  String get lunaStatusText {
    switch (this?.status?.toLowerCase() ?? '') {
      case 'delay':
        return 'Pending';
      case 'downloading':
        return 'Downloading';
      case 'completed':
        return 'Completed';
      case 'failed':
        return 'Failed';
      case 'paused':
        return 'Paused';
    }
    return this?.status ?? 'Unknown';
  }

  IconData get lunaStatusIcon {
    switch (this?.status?.toLowerCase() ?? '') {
      case 'delay':
        return Icons.schedule;
      case 'paused':
        return Icons.pause;
      case 'completed':
        return Icons.file_download;
      case 'downloading':
      case 'failed':
        return Icons.cloud_download;
    }
    return Icons.help;
  }

  Color get lunaStatusColor {
    if (this?.status?.toLowerCase() == 'completed')
      switch (this?.trackedDownloadStatus?.toLowerCase()) {
        case 'warning':
          return LunaColours.orange;
        case 'ok':
          return LunaColours.purple;
      }
    if (this?.status?.toLowerCase() == 'failed') return LunaColours.red;
    return Colors.white;
  }

  int get lunaPercentageComplete {
    if (this.sizeLeft == null || this.size == null || this.size == 0) return 0;
    double sizeFetched = this.size - this.sizeLeft;
    return ((sizeFetched / this.size) * 100).round();
  }
}
