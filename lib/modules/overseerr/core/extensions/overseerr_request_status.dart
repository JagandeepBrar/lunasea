import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

extension LunaOverseerrRequestStatusExtension on OverseerrRequestStatus? {
  String lunaName(OverseerrMediaStatus? mediaStatus) {
    if (mediaStatus != null) {
      switch (mediaStatus) {
        case OverseerrMediaStatus.PENDING:
          return 'overseerr.Pending'.tr();
        case OverseerrMediaStatus.PROCESSING:
          return 'overseerr.Requested'.tr();
        case OverseerrMediaStatus.PARTIALLY_AVAILABLE:
          return 'overseerr.PartiallyAvailable'.tr();
        case OverseerrMediaStatus.AVAILABLE:
          return 'overseerr.Available'.tr();
        case OverseerrMediaStatus.UNKNOWN:
          break;
      }
    }
    switch (this) {
      case OverseerrRequestStatus.PENDING:
        return 'overseerr.Pending'.tr();
      case OverseerrRequestStatus.APPROVED:
        return 'overseerr.Approved'.tr();
      case OverseerrRequestStatus.DECLINED:
        return 'overseerr.Declined'.tr();
      default:
        return LunaUI.TEXT_EMDASH;
    }
  }

  Color lunaColour(OverseerrMediaStatus? mediaStatus) {
    if (mediaStatus != null) {
      switch (mediaStatus) {
        case OverseerrMediaStatus.PARTIALLY_AVAILABLE:
        case OverseerrMediaStatus.AVAILABLE:
          return LunaColours.accent;
        case OverseerrMediaStatus.PENDING:
          return LunaColours.orange;
        case OverseerrMediaStatus.PROCESSING:
          return LunaColours.purple;
        case OverseerrMediaStatus.UNKNOWN:
        default:
      }
    }
    switch (this) {
      case OverseerrRequestStatus.PENDING:
        return LunaColours.orange;
      case OverseerrRequestStatus.APPROVED:
        return LunaColours.purple;
      case OverseerrRequestStatus.DECLINED:
        return LunaColours.red;
      default:
        return LunaColours.blueGrey;
    }
  }
}
