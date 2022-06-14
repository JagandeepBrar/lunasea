import 'package:lunasea/extensions/int/bytes.dart';

class SABnzbdStatusData {
  bool paused;
  double speed;
  double sizeLeft;
  String timeLeft;
  int speedlimit;

  SABnzbdStatusData({
    required this.paused,
    required this.speed,
    required this.sizeLeft,
    required this.timeLeft,
    required this.speedlimit,
  });

  String get currentSpeed {
    return '${speed.floor().asKilobytes(decimals: 1)}/s';
  }

  String get remainingSize {
    return sizeLeft.floor().asMegabytes(decimals: 1);
  }
}
