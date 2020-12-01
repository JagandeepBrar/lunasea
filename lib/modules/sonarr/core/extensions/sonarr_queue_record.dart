import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

extension SonarrQueueRecordExtension on SonarrQueueRecord {
    String get lunaStatusText {
        switch(this?.status?.toLowerCase() ?? '') {
            case 'delay': return 'Pending';
            case 'downloading': return 'Downloading';
            case 'completed': return 'Completed';
            case 'paused': return 'Paused';
        }
        return this?.status ?? 'Unknown';
    }

    IconData get lunaStatusIcon {
        switch(this?.status?.toLowerCase() ?? '') {
            case 'delay': return Icons.schedule;
            case 'downloading': return Icons.cloud_download;
            case 'completed': return Icons.cloud_download;
            case 'paused': return Icons.pause;
        }
        return Icons.help;
    }

    Color get lunaStatusColor {
        if(this?.status?.toLowerCase() == 'completed') switch(this?.trackedDownloadStatus?.toLowerCase()) {
            case 'warning': return LunaColours.orange;
            case 'ok': return LunaColours.purple;
        }
        return Colors.white;
    }
}