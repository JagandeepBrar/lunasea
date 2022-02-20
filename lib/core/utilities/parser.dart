abstract class LunaParser {
  /// Parse any [String] to a [DateTime] object if possible.
  static DateTime? dateTimeFromString(String? date) {
    return DateTime.tryParse(date ?? '');
  }

  /// Take a [DateTime] object and convert it to an ISO 8601 [String] representation.
  ///
  /// The format is `yyyy-MM-ddTHH:mm:ss.mmmuuuZ`.
  static String? dateTimeToISO8601(DateTime? date) {
    return date?.toIso8601String();
  }
}
