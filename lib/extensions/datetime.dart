import 'package:lunasea/database/tables/lunasea.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/system/localization.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';

extension DateTimeExtension on DateTime {
  String _formatted(String format) {
    final locale = LunaLanguage.current().languageTag;
    return DateFormat(format, locale).format(this.toLocal());
  }

  DateTime floor() {
    return DateTime(this.year, this.month, this.day);
  }

  String asTimeOnly() {
    if (LunaSeaDatabase.USE_24_HOUR_TIME.read()) return _formatted('Hm');
    return _formatted('jm');
  }

  String asDateOnly({
    shortenMonth = false,
  }) {
    final format = shortenMonth ? 'MMM dd, y' : 'MMMM dd, y';
    return _formatted(format);
  }

  String asDateTime({
    bool showSeconds = true,
    bool shortenMonth = false,
    String? delimiter,
  }) {
    final format = StringBuffer(shortenMonth ? 'MMM dd, y' : 'MMMM dd, y');
    format.write(delimiter ?? LunaUI.TEXT_BULLET.pad());
    format.write(LunaSeaDatabase.USE_24_HOUR_TIME.read() ? 'HH:mm' : 'hh:mm');
    if (showSeconds) format.write(':ss');
    if (!LunaSeaDatabase.USE_24_HOUR_TIME.read()) format.write(' a');

    return _formatted(format.toString());
  }

  String asPoleDate() {
    final year = this.year.toString().padLeft(4, '0');
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  String asAge() {
    final diff = DateTime.now().difference(this);
    if (diff.inSeconds < 15) return 'lunasea.JustNow'.tr();

    final days = diff.inDays.abs();
    if (days >= 1) {
      final years = (days / 365).floor();
      if (years == 1) return 'lunasea.OneYearAgo'.tr();
      if (years > 1) return 'lunasea.YearsAgo'.tr(args: [years.toString()]);

      final months = (days / 30).floor();
      if (months == 1) return 'lunasea.OneMonthAgo'.tr();
      if (months > 1) return 'lunasea.MonthsAgo'.tr(args: [months.toString()]);

      if (days == 1) return 'lunasea.OneDayAgo'.tr();
      if (days > 1) return 'lunasea.DaysAgo'.tr(args: [days.toString()]);
    }

    final hours = diff.inHours.abs();
    if (hours == 1) return 'lunasea.OneHourAgo'.tr();
    if (hours > 1) return 'lunasea.HoursAgo'.tr(args: [hours.toString()]);

    final mins = diff.inMinutes.abs();
    if (mins == 1) return 'lunasea.OneMinuteAgo'.tr();
    if (mins > 1) return 'lunasea.MinutesAgo'.tr(args: [mins.toString()]);

    final secs = diff.inSeconds.abs();
    if (secs == 1) return 'lunasea.OneSecondAgo'.tr();
    return 'lunasea.SecondsAgo'.tr(args: [secs.toString()]);
  }

  String asDaysDifference() {
    final diff = DateTime.now().difference(this);
    final days = diff.inDays.abs();
    if (days == 0) return 'lunasea.Today'.tr();

    final years = (days / 365).floor();
    if (years == 1) return 'lunasea.OneYear'.tr();
    if (years > 1) return 'lunasea.Years'.tr(args: [years.toString()]);

    final months = (days / 30).floor();
    if (months == 1) return 'lunasea.OneMonth'.tr();
    if (months > 1) return 'lunasea.Months'.tr(args: [months.toString()]);

    if (days == 1) return 'lunasea.OneDay'.tr();
    return 'lunasea.Days'.tr(args: [days.toString()]);
  }
}
