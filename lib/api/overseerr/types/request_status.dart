import 'package:lunasea/core.dart';

const _PENDING = 1;
const _APPROVED = 2;
const _DECLINED = 3;

@JsonEnum()
enum OverseerrRequestStatus {
  @JsonValue(_PENDING)
  PENDING,
  @JsonValue(_APPROVED)
  APPROVED,
  @JsonValue(_DECLINED)
  DECLINED,
}

/// Extension on [OverseerrRequestStatus] to implement extended functionality.
extension OverseerrRequestStatusExtension on OverseerrRequestStatus {
  int get value {
    switch (this) {
      case OverseerrRequestStatus.PENDING:
        return _PENDING;
      case OverseerrRequestStatus.APPROVED:
        return _APPROVED;
      case OverseerrRequestStatus.DECLINED:
        return _DECLINED;
    }
  }
}
