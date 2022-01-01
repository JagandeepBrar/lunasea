part of overseerr_types;

enum OverseerrMediaStatus {
  UNKNOWN,
  PENDING,
  PROCESSING,
  PARTIALLY_AVAILABLE,
  AVAILABLE,
}

/// Extension on [OverseerrMediaStatus] to implement extended functionality.
extension OverseerrMediaStatusExtension on OverseerrMediaStatus {
  OverseerrMediaStatus? from(int? type) {
    switch (type) {
      case 1:
        return OverseerrMediaStatus.UNKNOWN;
      case 2:
        return OverseerrMediaStatus.PENDING;
      case 3:
        return OverseerrMediaStatus.PROCESSING;
      case 4:
        return OverseerrMediaStatus.PARTIALLY_AVAILABLE;
      case 5:
        return OverseerrMediaStatus.AVAILABLE;
      default:
        return null;
    }
  }

  int get value {
    switch (this) {
      case OverseerrMediaStatus.UNKNOWN:
        return 1;
      case OverseerrMediaStatus.PENDING:
        return 2;
      case OverseerrMediaStatus.PROCESSING:
        return 3;
      case OverseerrMediaStatus.PARTIALLY_AVAILABLE:
        return 4;
      case OverseerrMediaStatus.AVAILABLE:
        return 5;
    }
  }
}
