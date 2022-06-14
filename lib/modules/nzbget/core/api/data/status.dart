import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/extensions/int/duration.dart';

class NZBGetStatusData {
  bool paused;
  int speed;
  int remainingHigh;
  int remainingLow;
  int speedlimit;

  NZBGetStatusData({
    required this.paused,
    required this.speed,
    required this.remainingHigh,
    required this.remainingLow,
    required this.speedlimit,
  });

  int get remaining {
    return (remainingHigh << 32) + remainingLow;
  }

  String get currentSpeed {
    return '${speed.asBytes(decimals: 1)}/s';
  }

  String get remainingString {
    return remaining.asBytes(decimals: 1);
  }

  String get timeLeft {
    return speed == 0
        ? '0:00:00'
        : ((remaining / speed).floor()).asTrackDuration();
  }

  String get speedlimitString {
    return speedlimit == 0 ? 'Unlimited' : speedlimit.asBytes(decimals: 0);
  }
}
