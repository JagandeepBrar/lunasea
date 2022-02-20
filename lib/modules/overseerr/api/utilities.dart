import 'types.dart';

abstract class OverseerrUtilities {
  static OverseerrMediaType? mediaTypeFromJson(String? type) {
    return OverseerrMediaType.TV.from(type);
  }

  static String? mediaTypeToJson(OverseerrMediaType? type) {
    return type?.value;
  }

  static OverseerrMediaStatus? mediaStatusFromJson(int? type) {
    return OverseerrMediaStatus.UNKNOWN.from(type);
  }

  static int? mediaStatusToJson(OverseerrMediaStatus? type) {
    return type?.value;
  }

  static OverseerrRequestStatus? requestStatusFromJson(int? type) {
    return OverseerrRequestStatus.APPROVED.from(type);
  }

  static int? requestStatusToJson(OverseerrRequestStatus? type) {
    return type?.value;
  }
}
