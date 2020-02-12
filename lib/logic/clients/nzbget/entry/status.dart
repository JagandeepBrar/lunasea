import 'package:lunasea/core.dart';

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
        return '${speed?.lsBytes_BytesToString(decimals: 1)}/s';
    }

    String get remainingString {
        return remaining?.lsBytes_BytesToString(decimals: 1);
    }
    
    String get timeLeft {
        return speed == 0 ? '0:00:00' : Functions.secondsToTimestamp((remaining/speed).floor());   
    }

    String get speedlimitString {
        return speedlimit == 0 ? 'Unlimited' : speedlimit?.lsBytes_BytesToString(decimals: 0);
    }
}
