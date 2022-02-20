import 'package:lunasea/core.dart';

const _MOST_RECENT = 'added';
const _LAST_MODIFIED = 'modified';

@JsonEnum()
enum OverseerrIssueSortType {
  @JsonValue(_MOST_RECENT)
  MOST_RECENT,
  @JsonValue(_LAST_MODIFIED)
  LAST_MODIFIED,
}

extension OverseerrIssueSortTypeExtension on OverseerrIssueSortType {
  String get key {
    switch (this) {
      case OverseerrIssueSortType.MOST_RECENT:
        return _MOST_RECENT;
      case OverseerrIssueSortType.LAST_MODIFIED:
        return _LAST_MODIFIED;
    }
  }
}
