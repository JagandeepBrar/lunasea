import 'package:lunasea/core.dart';

extension DoubleExtension on double {
  /// Given a double (of hours), return a string signifying how long ago it occurred.
  ///
  /// Time greater than 48 hours => "x Days Ago" else "x Hours Ago"
  String lunaHoursToAge() {
    if (this < 0) return LunaUI.TEXT_EMDASH;
    // Small buffer of 5% of an hour, 3 minute
    if (this <= 0.05) return 'lunasea.JustNow'.tr();
    int days = (this / 24).floor();
    if (this > 48) return 'lunasea.DaysAgo'.tr(args: [days.toString()]);
    return this == 1
        ? 'lunasea.OneHourAgo'.tr()
        : 'lunasea.HoursAgo'.tr(args: [days.toString()]);
  }
}
