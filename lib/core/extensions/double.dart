import 'package:lunasea/core.dart';

extension DoubleExtension on double {
  String get asTimeAgo {
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
