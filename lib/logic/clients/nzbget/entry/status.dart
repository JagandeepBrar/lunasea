import 'package:lunasea/system/functions.dart';

class NZBGetStatusEntry {
    bool paused;
    int speed;
    int remainingHigh;
    int remainingLow;
    int speedlimit;

    NZBGetStatusEntry(
        this.paused,
        this.speed,
        this.remainingHigh,
        this.remainingLow,
        this.speedlimit,
    );

    int get remaining {
        return (remainingHigh << 32)+remainingLow;
    }

    String get currentSpeed {
        return '${Functions.bytesToReadable(speed, decimals: 1)}/s';
    }

    String get remainingString {
        return Functions.bytesToReadable(remaining, decimals: 1);
    }
    
    String get timeLeft {
        return speed == 0 ? '0:00:00' : Functions.secondsToTimestamp((remaining/speed).floor());   
    }

    String get speedlimitString {
        return speedlimit == 0 ? 'Unlimited' : Functions.bytesToReadable(speedlimit, decimals: 0);
    }
}
