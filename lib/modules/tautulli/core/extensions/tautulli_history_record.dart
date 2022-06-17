import 'package:flutter/material.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/modules/tautulli.dart';

extension TautulliHistoryRecordExtension on TautulliHistoryRecord {
  String get lsFullTitle => [
        if (this.title != null && this.title!.isNotEmpty) this.title,
        if (this.parentTitle != null && this.parentTitle!.isNotEmpty)
          '\n${this.parentTitle}',
        if (this.grandparentTitle != null && this.grandparentTitle!.isNotEmpty)
          '\n${this.grandparentTitle}',
      ].join();

  String? get lsTitle =>
      this.grandparentTitle == null || this.grandparentTitle!.isEmpty
          ? this.parentTitle == null || this.parentTitle!.isEmpty
              ? this.title == null || this.title!.isEmpty
                  ? 'Unknown Title'
                  : this.title
              : this.parentTitle
          : this.grandparentTitle;

  IconData get lunaWatchStatusIcon {
    switch (this.watchedStatus) {
      case TautulliWatchedStatus.PARTIALLY_WATCHED:
        return Icons.radio_button_checked_rounded;
      case TautulliWatchedStatus.WATCHED:
        return Icons.check_circle_rounded;
      case TautulliWatchedStatus.UNWATCHED:
      default:
        return Icons.radio_button_unchecked_rounded;
    }
  }

  String get lsDate => this.date?.asAge() ?? 'Unknown';

  String get lsStatus {
    switch (this.watchedStatus) {
      case TautulliWatchedStatus.UNWATCHED:
        return 'Incompleted';
      case TautulliWatchedStatus.PARTIALLY_WATCHED:
        return 'Partially Completed';
      case TautulliWatchedStatus.WATCHED:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }

  String get lsState {
    switch (this.state) {
      case TautulliSessionState.PLAYING:
        return 'Playing';
      case TautulliSessionState.PAUSED:
        return 'Paused';
      case TautulliSessionState.BUFFERING:
        return 'Buffering';
      case TautulliSessionState.NULL:
      default:
        return 'Finished';
    }
  }
}
