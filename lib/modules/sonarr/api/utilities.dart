library sonarr_utilities;

import 'package:lunasea/modules/sonarr.dart';

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

  static SonarrProtocol? protocolFromJson(String? protocol) =>
      SonarrProtocol.USENET.from(protocol);
  static String? protocolToJson(SonarrProtocol? protocol) => protocol?.value;

  static SonarrQueueStatus? queueStatusFromJson(String? status) =>
      SonarrQueueStatus.DOWNLOADING.from(status);
  static String? queueStatusToJson(SonarrQueueStatus? status) => status?.value;

  static SonarrTrackedDownloadState? queueTrackedDownloadStateFromJson(
          String? state) =>
      SonarrTrackedDownloadState.DOWNLOADING.from(state);
  static String? queueTrackedDownloadStateToJson(
          SonarrTrackedDownloadState? state) =>
      state?.value;

  static SonarrTrackedDownloadStatus? queueTrackedDownloadStatusFromJson(
          String? status) =>
      SonarrTrackedDownloadStatus.OK.from(status);
  static String? queueTrackedDownloadStatusToJson(
          SonarrTrackedDownloadStatus? status) =>
      status?.value;
}
