import 'package:tautulli/tautulli.dart';

extension TautulliHistoryRecordExtension on TautulliHistoryRecord {
    /// Returns a the header that should be used for titles, appbars, etc.
    String get header => this.grandparentTitle == null || this.grandparentTitle.isEmpty
        ? this.parentTitle == null || this.parentTitle.isEmpty
            ? this.title == null || this.title.isEmpty
                ? 'Unknown Title'
                : this.title
            : this.parentTitle
        : this.grandparentTitle;
}