import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

extension ReadarrQueueRecordExtension on ReadarrQueueRecord {
  Tuple3<String, IconData, Color> lunaStatusParameters({
    bool canBeWhite = true,
  }) {
    ReadarrQueueStatus? _status = this.status;
    ReadarrTrackedDownloadStatus? _tStatus = this.trackedDownloadStatus;
    ReadarrTrackedDownloadState? _tState = this.trackedDownloadState;

    String _title = 'readarr.Downloading'.tr();
    IconData _icon = Icons.cloud_download_rounded;
    Color _color = canBeWhite ? Colors.white : LunaColours.blueGrey;

    // Paused
    if (_status == ReadarrQueueStatus.PAUSED) {
      _icon = Icons.pause_rounded;
      _title = 'readarr.Paused'.tr();
    }

    // Queued
    if (_status == ReadarrQueueStatus.QUEUED) {
      _icon = Icons.cloud_rounded;
      _title = 'readarr.Queued'.tr();
    }

    // Complete
    if (_status == ReadarrQueueStatus.COMPLETED) {
      _title = 'readarr.Downloaded'.tr();
      _icon = Icons.file_download_rounded;

      if (_tState == ReadarrTrackedDownloadState.IMPORT_PENDING) {
        _title = 'readarr.DownloadedWaitingToImport'.tr();
        _color = LunaColours.purple;
      }
      if (_tState == ReadarrTrackedDownloadState.IMPORTING) {
        _title = 'readarr.DownloadedImporting'.tr();
        _color = LunaColours.purple;
      }
      if (_tState == ReadarrTrackedDownloadState.FAILED_PENDING) {
        _title = 'readarr.DownloadedWaitingToProcess'.tr();
        _color = LunaColours.red;
      }
    }

    if (_tStatus == ReadarrTrackedDownloadStatus.WARNING) {
      _color = LunaColours.orange;
    }

    // Delay
    if (_status == ReadarrQueueStatus.DELAY) {
      _title = 'readarr.Pending'.tr();
      _icon = Icons.schedule_rounded;
    }

    // Download Client Unavailable
    if (_status == ReadarrQueueStatus.DOWNLOAD_CLIENT_UNAVAILABLE) {
      _title = 'readarr.PendingWithMessage'.tr(
        args: ['readarr.DownloadClientUnavailable'.tr()],
      );
      _icon = Icons.schedule_rounded;
      _color = LunaColours.orange;
    }

    // Failed
    if (_status == ReadarrQueueStatus.FAILED) {
      _title = 'readarr.DownloadFailed'.tr();
      _icon = Icons.cloud_download_rounded;
      _color = LunaColours.red;
    }

    // Warning
    if (_status == ReadarrQueueStatus.WARNING) {
      _title = 'readarr.DownloadWarningWithMessage'.tr(args: [
        'readarr.CheckDownloadClient'.tr(),
      ]);
      _icon = Icons.cloud_download_rounded;
      _color = LunaColours.orange;
    }

    // Error
    if (_tStatus == ReadarrTrackedDownloadStatus.ERROR) {
      if (_status == ReadarrQueueStatus.COMPLETED) {
        _title = 'readarr.ImportFailed'.tr();
        _icon = Icons.file_download_rounded;
        _color = LunaColours.red;
      } else {
        _title = 'readarr.DownloadFailed'.tr();
        _icon = Icons.cloud_download_rounded;
        _color = LunaColours.red;
      }
    }

    return Tuple3(_title, _icon, _color);
  }

  String lunaPercentage() {
    if (this.sizeleft == null || this.size == null || this.size == 0)
      return '0%';
    double sizeFetched = this.size! - this.sizeleft!;
    int percentage = ((sizeFetched / this.size!) * 100).round();
    return '$percentage%';
  }

  String lunaTimeLeft() {
    return this.timeleft ?? LunaUI.TEXT_EMDASH;
  }
}
