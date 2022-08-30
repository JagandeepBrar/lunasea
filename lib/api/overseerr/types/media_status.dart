import 'package:lunasea/core.dart';

const _UNKNOWN = 1;
const _PENDING = 2;
const _PROCESSING = 3;
const _PARTIALLY_AVAILABLE = 4;
const _AVAILABLE = 5;

@JsonEnum()
enum OverseerrMediaStatus {
  @JsonValue(_UNKNOWN)
  UNKNOWN,
  @JsonValue(_PENDING)
  PENDING,
  @JsonValue(_PROCESSING)
  PROCESSING,
  @JsonValue(_PARTIALLY_AVAILABLE)
  PARTIALLY_AVAILABLE,
  @JsonValue(_AVAILABLE)
  AVAILABLE,
}

/// Extension on [OverseerrMediaStatus] to implement extended functionality.
extension OverseerrMediaStatusExtension on OverseerrMediaStatus {
  int get key {
    switch (this) {
      case OverseerrMediaStatus.UNKNOWN:
        return _UNKNOWN;
      case OverseerrMediaStatus.PENDING:
        return _PENDING;
      case OverseerrMediaStatus.PROCESSING:
        return _PROCESSING;
      case OverseerrMediaStatus.PARTIALLY_AVAILABLE:
        return _PARTIALLY_AVAILABLE;
      case OverseerrMediaStatus.AVAILABLE:
        return _AVAILABLE;
    }
  }
}
