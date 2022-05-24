abstract class LunaParser {
  static DateTime? dateTimeFromString(String? date) {
    return DateTime.tryParse(date ?? '');
  }

  static String? dateTimeToISO8601(DateTime? date) {
    return date?.toIso8601String();
  }
}
