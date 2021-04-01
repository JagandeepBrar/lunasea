import 'package:lunasea/core.dart';

extension DurationExtension on Duration {
    /// Return a string representation of the timestamp.
    /// 
    /// Format example: HH:MM:SS or MM:SS if the duration is less than one hour
    String get lunaTimestamp => [
        if(this.inHours != 0) this.inHours.toString().padLeft(2, '0'),
        (this.inMinutes%60).toString().padLeft(2, '0'),
        (this.inSeconds%60).toString().padLeft(2, '0'),
    ].join(':');

    /// Returns a string representation of the timestamp as words.
    /// 
    /// Format example: 1 Day, 23 Hours, 10 Minutes
    String get lunaTimestampWords {
        String days, hours, minutes;
        if(this.inDays == 1) days = '1 Day';
        if(this.inDays > 1) days = '${this.inDays.toString()} Days';
        if(this.inHours == 1) hours = '1 Hour';
        if(this.inHours > 1) hours = '${(this.inHours%24).toString()} Hours';
        if(this.inMinutes == 1) minutes = '1 Minute';
        if(this.inMinutes > 1) minutes = '${(this.inMinutes%60).toString()} Minutes';
        return [
            if(days != null) days,
            if(hours != null) hours,
            if(minutes != null) minutes,
            if(minutes == null) LunaUI.TEXT_EMDASH,
        ].join(' ');
    }
}
