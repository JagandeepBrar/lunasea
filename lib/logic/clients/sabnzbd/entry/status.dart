import 'package:lunasea/core.dart';

class SABnzbdStatusEntry {
    bool paused;
    double speed;
    double sizeLeft;
    String timeLeft;
    int speedlimit;

    SABnzbdStatusEntry(
        this.paused,
        this.speed,
        this.sizeLeft,
        this.timeLeft,
        this.speedlimit,
    );

    String get currentSpeed {
        return '${speed?.floor()?.lsKilobytesToString(decimals: 1)}/s';
    }

    String get remainingSize {
        return sizeLeft?.floor()?.lsMegabytesToString(decimals: 1);
    }
}
