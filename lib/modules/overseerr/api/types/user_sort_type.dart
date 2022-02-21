import 'package:lunasea/core.dart';

const _CREATED = 'created';
const _DISPLAY_NAME = 'displayname';
const _REQUESTS = 'requests';
const _UPDATED = 'updated';

@JsonEnum()
enum OverseerrUserSortType {
  @JsonValue(_CREATED)
  CREATED,
  @JsonValue(_DISPLAY_NAME)
  DISPLAY_NAME,
  @JsonValue(_REQUESTS)
  REQUESTS,
  @JsonValue(_UPDATED)
  UPDATED,
}

extension OverseerrUserSortTypeExtension on OverseerrUserSortType {
  String get key {
    switch (this) {
      case OverseerrUserSortType.CREATED:
        return _CREATED;
      case OverseerrUserSortType.DISPLAY_NAME:
        return _DISPLAY_NAME;
      case OverseerrUserSortType.REQUESTS:
        return _REQUESTS;
      case OverseerrUserSortType.UPDATED:
        return _UPDATED;
    }
  }
}
