import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

extension ReadarrHistoryRecordLunaExtension on ReadarrHistoryRecord {
  String lunaSeriesTitle() {
    return this.series?.title ?? LunaUI.TEXT_EMDASH;
  }

  bool lunaHasPreferredWordScore() {
    return (this.data!['preferredWordScore'] ?? '0') != '0';
  }

  String lunaPreferredWordScore() {
    if (lunaHasPreferredWordScore()) {
      int? _preferredScore = int.tryParse(this.data!['preferredWordScore']);
      if (_preferredScore != null) {
        String _prefix = _preferredScore > 0 ? '+' : '';
        return '$_prefix${this.data!['preferredWordScore']}';
      }
    }
    return LunaUI.TEXT_EMDASH;
  }
}
