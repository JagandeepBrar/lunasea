extension IntegerBytesExtension on int? {
  static const _BIT_SIZES = ['b', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb', 'Eb'];
  static const _BYTE_SIZES = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB'];

  String _bytesToString({int decimals = 2, position = 0, bool bytes = true}) {
    if (this == null || this! <= 0) return '${0.toStringAsFixed(decimals)} B';
    int chunk = bytes ? 1024 : 1000;
    double size = this!.toDouble();
    while (size > chunk) {
      size /= chunk;
      position++;
    }
    return '${size.toStringAsFixed(decimals)} ${bytes ? _BYTE_SIZES[position] : _BIT_SIZES[position]}';
  }

  /// Given an integer of the number of bytes/bits, return a string representation.
  String lunaBytesToString({int decimals = 2, bool bytes = true}) =>
      _bytesToString(decimals: decimals, position: 0, bytes: bytes);

  /// Given an integer of the number of kilobytes/kilobits, return a string representation.
  String lunaKilobytesToString({int decimals = 2, bool bytes = true}) =>
      _bytesToString(decimals: decimals, position: 1, bytes: bytes);

  /// Given an integer of the number of megabytes/megabits, return a string representation.
  String lunaMegabytesToString({int decimals = 2, bool bytes = true}) =>
      _bytesToString(decimals: decimals, position: 2, bytes: bytes);

  /// Given an integer of the number of gigabytes/gigabits, return a string representation.
  String lunaGigabytesToString({int decimals = 2, bool bytes = true}) =>
      _bytesToString(decimals: decimals, position: 3, bytes: bytes);
}

extension IntegerTimeExtension on int? {
  static const int _MINUTE_IN_SECONDS = 60;
  static const int _HOUR_IN_SECONDS = 60 * 60;
  static const int _DAY_IN_SECONDS = 60 * 60 * 24;

  /// Given an integer duration, converts it to a readable string. Assumes the duration is in seconds, use the `divisor` and `multipler` variables to easily modify the input.
  ///
  /// Only contains the highest factor (2.5 Days would return 2 Days).
  String lunaDuration({int divisor = 1, int multiplier = 1}) {
    if (this == null) return '';
    int duration = ((this! * multiplier) / divisor).floor();
    int days = (duration / _DAY_IN_SECONDS).floor();
    if (days > 0) return '$days ${days == 1 ? 'Day' : 'Days'}';
    int hours = (duration / _HOUR_IN_SECONDS).floor();
    if (hours > 0) return '$hours ${hours == 1 ? 'Hour' : 'Hours'}';
    int minutes = (duration / _MINUTE_IN_SECONDS).floor();
    if (minutes > 0) return '$minutes ${minutes == 1 ? 'Minute' : 'Minutes'}';
    return '$duration ${duration == 1 ? 'Second' : 'Seconds'}';
  }

  /// Given an integer duration, converts it to a readable runtime string. Assumes the duration is in seconds, use the `divisor` and `multipler` variables to easily modify the input.
  ///
  /// Format example: 1h 23m
  String lunaRuntime({int divisor = 1, int multiplier = 1}) {
    if (this == null || this == 0) return '';
    double runtime = ((this! * multiplier) / divisor);
    if (runtime < 60) return '${runtime.floor()}m';
    return '${(runtime / 60).floor()}h ${(runtime - ((runtime / 60).floor() * 60)).floor()}m';
  }

  /// Given an integer duration, converts it to a readable timestamp string. Assumes the duration is in seconds, use the `divisor` and `multiplier` variables to easily modify the input.
  ///
  /// Format example: 1:23:45 (1 hour, 23 minutes, and 45 seconds)
  String lunaTimestamp({int divisor = 1, int multiplier = 1}) {
    if (this == null) return '';
    int duration = ((this! * multiplier) / divisor).floor();
    int hours = 0, minutes = 0;
    while (duration >= _HOUR_IN_SECONDS) {
      duration -= _HOUR_IN_SECONDS;
      hours++;
    }
    while (duration >= _MINUTE_IN_SECONDS) {
      duration -= _MINUTE_IN_SECONDS;
      minutes++;
    }
    return '${hours.toString().padLeft(1, '0')}:${minutes.toString().padLeft(2, '0')}:${duration.toString().padLeft(2, '0')}';
  }
}
