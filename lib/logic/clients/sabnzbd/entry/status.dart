import 'package:lunasea/system/functions.dart';

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
        return '${Functions.bytesToReadable(speed.floor()*1024, decimals: 1)}/s';
    }

    String get remainingSize {
        return '${Functions.bytesToReadable(sizeLeft.floor()*1024*1024, decimals: 1)}';
    }
}
