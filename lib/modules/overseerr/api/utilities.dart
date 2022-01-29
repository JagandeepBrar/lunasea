import 'types.dart';

abstract class OverseerrUtilities {
  static DateTime? dateTimeFromJson(String? date) =>
      DateTime.tryParse(date ?? '');
  static String? dateTimeToJson(DateTime? date) => date?.toIso8601String();

  static OverseerrMediaType? mediaTypeFromJson(String? type) =>
      OverseerrMediaType.TV.from(type);
  static String? mediaTypeToJson(OverseerrMediaType? type) => type?.value;

  static OverseerrMediaStatus? mediaStatusFromJson(int? type) =>
      OverseerrMediaStatus.UNKNOWN.from(type);
  static int? mediaStatusToJson(OverseerrMediaStatus? type) => type?.value;

  static OverseerrRequestStatus? requestStatusFromJson(int? type) =>
      OverseerrRequestStatus.APPROVED.from(type);
  static int? requestStatusToJson(OverseerrRequestStatus? type) => type?.value;
}
