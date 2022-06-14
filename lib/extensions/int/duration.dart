import 'package:lunasea/vendor.dart';

extension IntegerAsDurationExtension on int? {
  static const int _MINUTE_IN_SECONDS = 60;
  static const int _HOUR_IN_SECONDS = _MINUTE_IN_SECONDS * 60;
  static const int _DAY_IN_SECONDS = _HOUR_IN_SECONDS * 24;

  String asWordDuration({
    int multiplier = 1,
    int divisor = 1,
  }) {
    if (this == null || this! <= 0) return 'lunasea.Unknown'.tr();
    final seconds = ((this! * multiplier) / divisor).floor();

    final days = seconds ~/ _DAY_IN_SECONDS;
    if (days > 1) {
      return 'lunasea.Days'.tr(args: [days.toString()]);
    }

    final hours = seconds ~/ _HOUR_IN_SECONDS;
    if (hours > 1) {
      return 'lunasea.Hours'.tr(args: [hours.toString()]);
    }

    final minutes = seconds ~/ _MINUTE_IN_SECONDS;
    if (minutes > 0) {
      return 'lunasea.Minutes'.tr(args: [minutes.toString()]);
    }

    return 'lunasea.Seconds'.tr(args: [seconds.toString()]);
  }

  String asVideoDuration({
    int multiplier = 1,
    int divisor = 1,
  }) {
    if (this == null || this! <= 0) return 'lunasea.Unknown'.tr();

    final minutes = ((this! * multiplier) / divisor).floor();
    final hours = (minutes ~/ 60);
    final remainder = (minutes - (60 * hours));

    if (minutes < 60) return '${minutes}m';
    return '${hours}h ${remainder}m';
  }

  String asTrackDuration({
    int multiplier = 1,
    int divisor = 1,
  }) {
    if (this == null || this! <= 0) return '00:00';

    int duration = ((this! * multiplier) / divisor).floor();
    int hourCounter = 0, minuteCounter = 0;

    while (duration >= _HOUR_IN_SECONDS) {
      duration -= _HOUR_IN_SECONDS;
      hourCounter++;
    }
    while (duration >= _MINUTE_IN_SECONDS) {
      duration -= _MINUTE_IN_SECONDS;
      minuteCounter++;
    }

    final hours = hourCounter.toString().padLeft(1, '0');
    final minutes = minuteCounter.toString().padLeft(2, '0');
    final seconds = duration.toString().padLeft(2, '0');

    if (hourCounter > 0) return '$hours:$minutes:$seconds';
    return '$minutes:$seconds';
  }
}
