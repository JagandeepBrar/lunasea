import 'package:lunasea/core.dart';

extension DurationExtension on Duration {
    /// Creates a HH:MM:SS timestamp
    //ignore: non_constant_identifier_names
    String lsDuration_timestamp() {
        String hours = this.inHours.toString().padLeft(2, '0');
        String minutes = (this.inMinutes%60).toString().padLeft(2, '0');
        String seconds = (this.inSeconds%60).toString().padLeft(2, '0');
        return [
            if(hours != '00') '$hours:',
            '$minutes:',
            '$seconds',
        ].join();
    }


    /// Creates a full timestamp, akin to 1 Day, 23 Hours, 10 Minutes
    //ignore: non_constant_identifier_names
    String lsDuration_fullTimestamp() {
        String days, hours, minutes;
        if(this.inDays == 1) days = '1 Day ';
        if(this.inDays > 1) days = '${this.inDays.toString()} Days ';
        if(this.inHours == 1) hours = '1 Hour ';
        if(this.inHours > 1) hours = '${(this.inHours%24).toString()} Hours ';
        if(this.inMinutes == 1) minutes = '1 Minute ';
        if(this.inMinutes > 1) minutes = '${(this.inMinutes%60).toString()} Minutes ';
        return [
            if(days != null) days,
            if(hours != null) hours,
            if(minutes != null) minutes,
            if(minutes == null) Constants.TEXT_EMDASH,
        ].join();
    }
}
