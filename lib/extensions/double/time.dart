import 'package:lunasea/core.dart';

extension DoubleAsTimeExtension on double? {
  String asTimeAgo() {
    if (this == null || this! < 0) return LunaUI.TEXT_EMDASH;

    double hours = this!;
    double minutes = (this! * 60);
    double days = (this! / 24);

    if (minutes <= 2) {
      return 'lunasea.JustNow'.tr();
    }

    if (minutes <= 120) {
      return 'lunasea.MinutesAgo'.tr(args: [minutes.round().toString()]);
    }

    if (hours <= 48) {
      return 'lunasea.HoursAgo'.tr(args: [hours.toStringAsFixed(1)]);
    }

    return 'lunasea.DaysAgo'.tr(args: [days.round().toString()]);
  }
}
