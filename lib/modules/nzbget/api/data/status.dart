import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class NZBGetStatusData {
    bool paused;
    int speed;
    int remainingHigh;
    int remainingLow;
    int speedlimit;

    NZBGetStatusData({
        @required this.paused,
        @required this.speed,
        @required this.remainingHigh,
        @required this.remainingLow,
        @required this.speedlimit,
    });

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
        return speed == 0 ? '0:00:00' : ((remaining/speed).floor()).lsTime_timestampString();   
    }

    String get speedlimitString {
        return speedlimit == 0 ? 'Unlimited' : speedlimit?.lsBytes_BytesToString(decimals: 0);
    }
}
