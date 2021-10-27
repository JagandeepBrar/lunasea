library sonarr_utilities;

import 'package:sonarr/types.dart';

class SonarrUtilities {
  SonarrUtilities._();

  static DateTime? dateTimeFromJson(String? date) {
    return DateTime.tryParse(date ?? '');
  }

  static String? dateTimeToJson(DateTime? date) {
    return date?.toIso8601String();
  }

  static SonarrEventType? eventTypeFromJson(String? type) {
    return SonarrEventType.GRABBED.from(type);
  }

  static String? eventTypeToJson(SonarrEventType? type) {
    return type?.value;
  }

  static SonarrSeriesType? seriesTypeFromJson(String? type) {
    return SonarrSeriesType.STANDARD.from(type);
  }

  static String? seriesTypeToJson(SonarrSeriesType? type) {
    return type?.value;
  }

  static SonarrHistorySortKey? historySortKeyFromJson(String? key) {
    return SonarrHistorySortKey.DATE.from(key);
  }

  static String? historySortKeyToJson(SonarrHistorySortKey? key) {
    return key?.value;
  }

  static SonarrWantedMissingSortKey? wantedMissingSortKeyFromJson(String? key) {
    return SonarrWantedMissingSortKey.AIRDATE_UTC.from(key);
  }

  static String? wantedMissingSortKeyToJson(SonarrWantedMissingSortKey? key) {
    return key?.value;
  }
}
