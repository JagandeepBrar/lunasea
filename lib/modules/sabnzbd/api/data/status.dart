import 'package:lunasea/core.dart';

class SABnzbdStatusData {
    bool paused;
    double speed;
    double sizeLeft;
    String timeLeft;
    int speedlimit;

    SABnzbdStatusData(
        this.paused,
        this.speed,
        this.sizeLeft,
        this.timeLeft,
        this.speedlimit,
    );

    String get currentSpeed {
        return '${speed?.floor()?.lsBytes_KilobytesToString(decimals: 1)}/s';
    }

    String get remainingSize {
        return sizeLeft?.floor()?.lsBytes_MegabytesToString(decimals: 1);
    }
}
