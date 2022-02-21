import 'package:lunasea/core.dart';

const _ALL = 'all';
const _APPROVED = 'approved';
const _AVAILABLE = 'available';
const _PENDING = 'pending';
const _PROCESSING = 'processing';
const _UNAVAILABLE = 'unavailable';

@JsonEnum()
enum OverseerrRequestFilterType {
  @JsonValue(_ALL)
  ALL,
  @JsonValue(_APPROVED)
  APPROVED,
  @JsonValue(_AVAILABLE)
  AVAILABLE,
  @JsonValue(_PENDING)
  PENDING,
  @JsonValue(_PROCESSING)
  PROCESSING,
  @JsonValue(_UNAVAILABLE)
  UNAVAILABLE,
}

/// Extension on [OverseerrRequestFilterType] to implement extended functionality.
extension OverseerrRequestFilterTypeExtension on OverseerrRequestFilterType {
  String get key {
    switch (this) {
      case OverseerrRequestFilterType.ALL:
        return _ALL;
      case OverseerrRequestFilterType.APPROVED:
        return _APPROVED;
      case OverseerrRequestFilterType.AVAILABLE:
        return _AVAILABLE;
      case OverseerrRequestFilterType.PENDING:
        return _PENDING;
      case OverseerrRequestFilterType.PROCESSING:
        return _PROCESSING;
      case OverseerrRequestFilterType.UNAVAILABLE:
        return _UNAVAILABLE;
    }
  }
}
