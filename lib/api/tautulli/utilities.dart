/// Library containing all utilty functions for Tautulli data.
library tautulli_utilities;

// ignore: always_use_package_imports
import './types.dart';

/// [TautulliUtilities] gives access to static, functional operations. These are mainly used for the (de)serialization of received JSON data.
///
/// [TautulliUtilities] cannot be initialized, all available functions are available statically.
class TautulliUtilities {
  TautulliUtilities._();

  /**
     * Ensure Typing
     */

  /// Ensures that the passed in value results in an integer.
  /// Can handle integers, doubles, strings, or booleans. Any other types will return null.
  ///
  /// - double => floor of original value
  /// - integer => original value
  /// - string  => try parsing string, else null
  /// - boolean => true = 1, false = 0
  static int? ensureIntegerFromJson(dynamic value) {
    switch (value.runtimeType) {
      case double:
        return (value as double).floor();
      case int:
        return (value as int?);
      case String:
        return int.tryParse(value as String);
      case bool:
        return (value as bool) ? 1 : 0;
      default:
        return null;
    }
  }

  /// Ensures that the passed in value results in a double.
  /// Can handle integers, doubles, strings, or booleans. Any other types will return null.
  ///
  /// - double => original value
  /// - integer => original value casted to double
  /// - string  => try parsing string, else null
  /// - boolean => true = 1, false = 0
  static double? ensureDoubleFromJson(dynamic value) {
    switch (value.runtimeType) {
      case double:
        return (value as double?);
      case int:
        return (value as int).toDouble();
      case String:
        return double.tryParse(value as String);
      case bool:
        return (value as bool) ? 1 : 0;
      default:
        return null;
    }
  }

  /// Ensures that the passed in value results in a boolean.
  /// Can handle integers, doubles, strings, or booleans. Any other types will return null.
  ///
  /// - double => 0 = false, anything else is true
  /// - integer => 0 = false, anything else is true
  /// - string => "" = false,  "0" = false, anything else is true
  /// - boolean => original value
  static bool? ensureBooleanFromJson(dynamic value) {
    switch (value.runtimeType) {
      case double:
        return (value as double?) == 0 ? false : true;
      case int:
        return (value as int?) == 0 ? false : true;
      case String:
        return (value as String?) == "" || value == "0" ? false : true;
      case bool:
        return (value as bool?);
      default:
        return null;
    }
  }

  /// Ensures that the passed in value results in a string.
  /// Can handle integers, doubles, strings, or booleans. Any other types will return null.
  ///
  /// - double => value `.toString()`
  /// - integer => value `.toString()`
  /// - string => original value
  /// - boolean => true = "1", false = "0"
  static String? ensureStringFromJson(dynamic value) {
    switch (value.runtimeType) {
      case double:
        return (value as double?).toString();
      case int:
        return (value as int?).toString();
      case String:
        return (value as String?);
      case bool:
        return (value as bool) ? "1" : "0";
      default:
        return null;
    }
  }

  /// Ensures that the passed in value results in a List<String>.
  /// Can handle lists, integers, doubles, strings, or booleans. Any other types will return null.
  ///
  /// - list => runs [ensureStringFromJson] on each element and returns the list
  /// - double => value `.toString()` within a list
  /// - integer => value `.toString()` within a list
  /// - string => original value within a list
  /// - boolean => true = "1", false = "0" within a list
  static List<String?>? ensureStringListFromJson(dynamic value) {
    switch (value.runtimeType) {
      case bool:
      case int:
      case String:
      case double:
        return [ensureStringFromJson(value)];
    }
    if (value is List<dynamic>)
      return value.map((element) => ensureStringFromJson(element)).toList();
    return null;
  }

  /// Ensures that the passed in value results in a List<int>.
  /// Can handle lists, integers, doubles, strings, or booleans. Any other types will return null.
  ///
  /// - list => runs [ensureStringFromJson] on each element and returns the list
  /// - double => value `.toString()` within a list
  /// - integer => value `.toString()` within a list
  /// - string => original value within a list
  /// - boolean => true = "1", false = "0" within a list
  static List<int?>? ensureIntegerListFromJson(dynamic value) {
    switch (value.runtimeType) {
      case bool:
      case int:
      case String:
      case double:
        return [ensureIntegerFromJson(value)];
    }
    if (value is List<dynamic>)
      return value.map((element) => ensureIntegerFromJson(element)).toList();
    return null;
  }

  /**
     * DateTime/Duration
     */

  /// Converts a String containing a unix/Epoch millisecond value to a [DateTime] object. Returns null on a poorly formatted string.
  static DateTime? millisecondsDateTimeFromJson(dynamic value) {
    try {
      switch (value.runtimeType) {
        case bool:
          return null;
        case int:
          return DateTime.fromMillisecondsSinceEpoch((value as int) * 1000);
        case double:
          return DateTime.fromMillisecondsSinceEpoch(
              ((value as double).floor()) * 1000);
        case String:
          return DateTime.fromMillisecondsSinceEpoch(
              (int.parse(value as String)) * 1000);
        default:
          return null;
      }
    } catch (_) {}
    return null;
  }

  /// Converts a value of milliseconds to a [Duration] object.
  ///
  /// - double => floor of value, passed to [Duration]
  /// - integer => value passed to [Duration]
  /// - string => value parsed as int, passed to [Duration]
  /// - boolean => null
  static Duration? millisecondsDurationFromJson(dynamic value) {
    try {
      switch (value.runtimeType) {
        case bool:
          return null;
        case int:
          return Duration(milliseconds: (value as int));
        case double:
          return Duration(milliseconds: (value as double).floor());
        case String:
          return Duration(milliseconds: int.parse(value as String));
        default:
          return null;
      }
    } catch (_) {}
    return null;
  }

  /// Converts a value of seconds to a [Duration] object.
  ///
  /// - double => floor of value, passed to [Duration]
  /// - integer => value passed to [Duration]
  /// - string => value parsed as int, passed to [Duration]
  /// - boolean => null
  static Duration? secondsDurationFromJson(dynamic value) {
    try {
      switch (value.runtimeType) {
        case bool:
          return null;
        case int:
          return Duration(seconds: (value as int));
        case double:
          return Duration(seconds: (value as double).floor());
        case String:
          return Duration(seconds: int.parse(value as String));
        default:
          return null;
      }
    } catch (_) {}
    return null;
  }

  /**
     * Other
     */

  /// Converts a string to a List\<String\>. The default delimiter is a comma `,`.
  static List<String>? stringToListStringFromJson(
    String? list, {
    String delimiter = ',',
  }) =>
      list?.split(delimiter);

  /**
     * Tautulli Types
     */

  /// Converts a string to a [TautulliMediaType] object.
  static TautulliMediaType? mediaTypeFromJson(String? type) =>
      TautulliMediaType.from(type);

  /// Converts a [TautulliMediaType] object back to its string representation.
  static String? mediaTypeToJson(TautulliMediaType? type) => type?.value;

  /// Converts a string to a [TautulliSessionState] object.
  static TautulliSessionState? sessionStateFromJson(String? state) =>
      TautulliSessionState.BUFFERING.from(state);

  /// Converts a [TautulliSessionState] object back to its string representation.
  static String? sessionStateToJson(TautulliSessionState? state) =>
      state?.value;

  /// Conerts a string to a [TautulliSessionLocation] object.
  static TautulliSessionLocation? sessionLocationFromJson(String? location) =>
      TautulliSessionLocation.LAN.from(location);

  /// Converts a [TautulliSessionLocation] object back to its string representation.
  static String? sessionLocationToJson(TautulliSessionLocation? location) =>
      location?.value;

  /// Converts a string to a [TautulliTranscodeDecision] object.
  static TautulliTranscodeDecision? transcodeDecisionFromJson(
          String? decision) =>
      TautulliTranscodeDecision.COPY.from(decision);

  /// Converts a [TautulliTranscodeDecision] object back to its string representation.
  static String? transcodeDecisionToJson(TautulliTranscodeDecision? decision) =>
      decision?.value;

  /// Converts a string to a [TautulliSectionType] object.
  static TautulliSectionType? sectionTypeFromJson(String? type) =>
      TautulliSectionType.MOVIE.from(type);

  /// Converts a [TautulliSectionType] object back to its string representation.
  static String? sectionTypeToJson(TautulliSectionType? type) => type?.value;

  /// Converts a string to a [TautulliUserGroup] object.
  static TautulliUserGroup? userGroupFromJson(String? group) =>
      TautulliUserGroup.ADMIN.from(group);

  /// Converts a [TautulliUserGroup] object back to its string representation.
  static String? userGroupToJson(TautulliUserGroup? group) => group?.value;

  /// Converts a double to a [TautulliWatchedStatus] object.
  static TautulliWatchedStatus? watchedStatusFromJson(num? watched) =>
      TautulliWatchedStatus.WATCHED.from(watched);

  /// Converts a [TautulliWatchedStatus] object back to its double representation.
  static num? watchedStatusToJson(TautulliWatchedStatus? watched) =>
      watched?.value;
}
