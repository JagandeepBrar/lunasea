import 'package:lunasea/core.dart';

extension DurationExtension on Duration {
    /// Return a string representation of the timestamp.
    /// 
    /// Format example: HH:MM:SS or MM:SS if the duration is less than one hour
    String get lunaTimestamp => [
        if(inHours != 0) inHours.toString().padLeft(2, '0'),
        (inMinutes%60).toString().padLeft(2, '0'),
        (inSeconds%60).toString().padLeft(2, '0'),
    ].join(':');

    /// Returns a string representation of the timestamp as words.
    /// 
    /// Format example: 1 Day, 23 Hours, 10 Minutes
    String get lunaTimestampWords {
        String days, hours, minutes;
        if(inDays == 1) days = '1 Day';
        if(inDays > 1) days = '${inDays.toString()} Days';
        if(inHours == 1) hours = '1 Hour';
        if(inHours > 1) hours = '${(inHours%24).toString()} Hours';
        if(inMinutes == 1) minutes = '1 Minute';
        if(inMinutes > 1) minutes = '${(inMinutes%60).toString()} Minutes';
        return [
            if(days != null) days,
            if(hours != null) hours,
            if(minutes != null) minutes,
            if(minutes == null) LunaUI.TEXT_EMDASH,
        ].join(' ');
    }
}
