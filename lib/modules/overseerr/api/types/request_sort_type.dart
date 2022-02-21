import 'package:lunasea/core.dart';

const _ADDED = 'added';
const _MODIFIED = 'modified';

@JsonEnum()
enum OverseerrRequestSortType {
  @JsonValue(_ADDED)
  ADDED,
  @JsonValue(_MODIFIED)
  MODIFIED,
}

extension OverseerrRequestSortTypeExtension on OverseerrRequestSortType {
  String get key {
    switch (this) {
      case OverseerrRequestSortType.ADDED:
        return _ADDED;
      case OverseerrRequestSortType.MODIFIED:
        return _MODIFIED;
    }
  }
}
