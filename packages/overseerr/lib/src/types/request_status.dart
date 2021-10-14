part of overseerr_types;

enum OverseerrRequestStatus {
  PENDING,
  APPROVED,
  DECLINED,
}

/// Extension on [OverseerrRequestStatus] to implement extended functionality.
extension OverseerrRequestStatusExtension on OverseerrRequestStatus {
  OverseerrRequestStatus? from(int? type) {
    switch (type) {
      case 1:
        return OverseerrRequestStatus.PENDING;
      case 2:
        return OverseerrRequestStatus.APPROVED;
      case 3:
        return OverseerrRequestStatus.DECLINED;
      default:
        return null;
    }
  }

  int get value {
    switch (this) {
      case OverseerrRequestStatus.PENDING:
        return 1;
      case OverseerrRequestStatus.APPROVED:
        return 2;
      case OverseerrRequestStatus.DECLINED:
        return 3;
    }
  }
}
