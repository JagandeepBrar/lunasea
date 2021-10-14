/// Library containing all utility functions for Overseerr data.
library overseerr_utilities;

import 'types.dart';

/// [OverseerrUtilities] gives access to static, functional operations. These are mainly used for the (de)serialization of received JSON data.
///
/// [OverseerrUtilities] cannot be initialized, all available functions are available statically.
class OverseerrUtilities {
  OverseerrUtilities._();

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
