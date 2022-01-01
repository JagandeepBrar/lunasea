part of overseerr_types;

enum OverseerrRequestFilterType {
  ALL,
  APPROVED,
  AVAILABLE,
  PENDING,
  PROCESSING,
  UNAVAILABLE,
}

/// Extension on [OverseerrRequestFilterType] to implement extended functionality.
extension OverseerrRequestFilterTypeExtension on OverseerrRequestFilterType {
  OverseerrRequestFilterType? from(String? type) {
    switch (type) {
      case 'all':
        return OverseerrRequestFilterType.ALL;
      case 'approved':
        return OverseerrRequestFilterType.APPROVED;
      case 'available':
        return OverseerrRequestFilterType.AVAILABLE;
      case 'pending':
        return OverseerrRequestFilterType.PENDING;
      case 'processing':
        return OverseerrRequestFilterType.PROCESSING;
      case 'unavailable':
        return OverseerrRequestFilterType.UNAVAILABLE;
      default:
        return null;
    }
  }

  String get value {
    switch (this) {
      case OverseerrRequestFilterType.ALL:
        return 'all';
      case OverseerrRequestFilterType.APPROVED:
        return 'approved';
      case OverseerrRequestFilterType.AVAILABLE:
        return 'available';
      case OverseerrRequestFilterType.PENDING:
        return 'pending';
      case OverseerrRequestFilterType.PROCESSING:
        return 'processing';
      case OverseerrRequestFilterType.UNAVAILABLE:
        return 'unavailable';
    }
  }
}
