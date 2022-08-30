/// Library containing all utility functions for Radarr data.
library radarr_utilities;

import 'package:lunasea/api/radarr/types.dart';

/// [RadarrUtilities] gives access to static, functional operations. These are mainly used for the (de)serialization of received JSON data.
///
/// [RadarrUtilities] cannot be initialized, all available functions are available statically.
class RadarrUtilities {
  RadarrUtilities._();

  static DateTime? dateTimeFromJson(String? date) =>
      DateTime.tryParse(date ?? '');
  static String? dateTimeToJson(DateTime? date) => date?.toIso8601String();

  /**
     * Radarr Types
     */

  /// Converts a string to a [RadarrAvailability] object.
  static RadarrAvailability? availabilityFromJson(String? type) =>
      RadarrAvailability.ANNOUNCED.from(type);

  /// Converts a [RadarrAvailability] object back to its string representation.
  static String? availabilityToJson(RadarrAvailability? type) => type?.value;

  /// Converts a string to a [RadarrCreditType] object.
  static RadarrCreditType? creditTypeFromJson(String? type) =>
      RadarrCreditType.CREW.from(type);

  /// Converts a [RadarrCreditType] object back to its string representation.
  static String? creditTypeToJson(RadarrCreditType? type) => type?.value;

  /// Converts a string to a [RadarrEventType] object.
  static RadarrEventType? eventTypeFromJson(String? type) =>
      RadarrEventType.GRABBED.from(type);

  /// Converts a [RadarrEventType] object back to its string representation.
  static String? eventTypeToJson(RadarrEventType? type) => type?.value;

  /// Converts a string to a [RadarrHistorySortKey] object.
  static RadarrHistorySortKey? historySortKeyFromJson(String? type) =>
      RadarrHistorySortKey.DATE.from(type);

  /// Converts a [RadarrHistorySortKey] object back to its string representation.
  static String? historySortKeyToJson(RadarrHistorySortKey? type) =>
      type?.value;

  /// Converts a string to a [RadarrQueueSortKey] object.
  static RadarrQueueSortKey? queueSortKeyFromJson(String? type) =>
      RadarrQueueSortKey.QUALITY.from(type);

  /// Converts a [RadarrQueueSortKey] object back to its string representation.
  static String? queueSortKeyToJson(RadarrQueueSortKey? type) => type?.value;

  /// Converts a string to a [RadarrSortDirection] object.
  static RadarrSortDirection? sortDirectionFromJson(String? type) =>
      RadarrSortDirection.ASCENDING.from(type);

  /// Converts a [RadarrSortDirection] object back to its string representation.
  static String? sortDirectionToJson(RadarrSortDirection? type) => type?.value;

  /// Converts a string to a [RadarrProtocol] object.
  static RadarrProtocol? protocolFromJson(String? protocol) =>
      RadarrProtocol.USENET.from(protocol);

  /// Converts a [RadarrProtocol] object back to its string representation.
  static String? protocolToJson(RadarrProtocol? protocol) => protocol?.value;

  /// Converts a string to a [RadarrHealthCheckType] object.
  static RadarrHealthCheckType? healthCheckTypeFromJson(String? health) =>
      RadarrHealthCheckType.NOTICE.from(health);

  /// Converts a [RadarrHealthCheckType] object back to its string representation.
  static String? healthCheckTypeToJson(RadarrHealthCheckType? health) =>
      health?.value;

  /// Converts a string to a [RadarrFileSystemType] object.
  static RadarrFileSystemType? fileSystemTypeFromJson(String? type) =>
      RadarrFileSystemType.FOLDER.from(type);

  /// Converts a [RadarrFileSystemType] object back to its string representation.
  static String? fileSystemTypeToJson(RadarrFileSystemType? type) =>
      type?.value;

  /// Converts a string to a [RadarrQueueRecordStatus] object.
  static RadarrQueueRecordStatus? queueRecordStatusFromJson(String? type) =>
      RadarrQueueRecordStatus.COMPLETED.from(type);

  /// Converts a [RadarrQueueRecordStatus] object back to its string representation.
  static String? queueRecordStatusToJson(RadarrQueueRecordStatus? type) =>
      type?.key;

  /// Converts a string to a [RadarrTrackedDownloadState] object.
  static RadarrTrackedDownloadState? trackedDownloadStateFromJson(
          String? type) =>
      RadarrTrackedDownloadState.DOWNLOADING.from(type);

  /// Converts a [RadarrTrackedDownloadState] object back to its string representation.
  static String? trackedDownloadStateToJson(RadarrTrackedDownloadState? type) =>
      type?.key;

  /// Converts a string to a [RadarrTrackedDownloadStatus] object.
  static RadarrTrackedDownloadStatus? trackedDownloadStatusFromJson(
          String? type) =>
      RadarrTrackedDownloadStatus.OK.from(type);

  /// Converts a [RadarrTrackedDownloadStatus] object back to its string representation.
  static String? trackedDownloadStatusToJson(
          RadarrTrackedDownloadStatus? type) =>
      type?.key;
}
