library readarr_utilities;

import 'package:lunasea/modules/readarr.dart';

class ReadarrUtilities {
  ReadarrUtilities._();

  static DateTime? dateTimeFromJson(String? date) {
    return DateTime.tryParse(date ?? '');
  }

  static String? dateTimeToJson(DateTime? date) {
    return date?.toIso8601String();
  }

  static ReadarrEventType? eventTypeFromJson(String? type) {
    return ReadarrEventType.GRABBED.from(type);
  }

  static String? eventTypeToJson(ReadarrEventType? type) {
    return type?.value;
  }

  static ReadarrHistorySortKey? historySortKeyFromJson(String? key) {
    return ReadarrHistorySortKey.DATE.from(key);
  }

  static String? historySortKeyToJson(ReadarrHistorySortKey? key) {
    return key?.value;
  }

  static ReadarrWantedMissingSortKey? wantedMissingSortKeyFromJson(
      String? key) {
    return ReadarrWantedMissingSortKey.RELEASE_DATE.from(key);
  }

  static String? wantedMissingSortKeyToJson(ReadarrWantedMissingSortKey? key) {
    return key?.value;
  }

  static ReadarrProtocol? protocolFromJson(String? protocol) =>
      ReadarrProtocol.USENET.from(protocol);
  static String? protocolToJson(ReadarrProtocol? protocol) => protocol?.value;

  static ReadarrQueueStatus? queueStatusFromJson(String? status) =>
      ReadarrQueueStatus.DOWNLOADING.from(status);
  static String? queueStatusToJson(ReadarrQueueStatus? status) => status?.value;

  static ReadarrTrackedDownloadState? queueTrackedDownloadStateFromJson(
          String? state) =>
      ReadarrTrackedDownloadState.DOWNLOADING.from(state);
  static String? queueTrackedDownloadStateToJson(
          ReadarrTrackedDownloadState? state) =>
      state?.value;

  static ReadarrTrackedDownloadStatus? queueTrackedDownloadStatusFromJson(
          String? status) =>
      ReadarrTrackedDownloadStatus.OK.from(status);
  static String? queueTrackedDownloadStatusToJson(
          ReadarrTrackedDownloadStatus? status) =>
      status?.value;
}
