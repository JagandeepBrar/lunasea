const DAY_IN_SECONDS = 60*60*24;
const HOUR_IN_SECONDS = 60*60;
const MINUTE_IN_SECONDS = 60;

extension IntegerTimeExtension on int {
    // ignore: non_constant_identifier_names
    String lsTime_runtimeString({ bool dot = false, int divisor = 1, int multipler = 1 }) {
        if(this == null || this == 0) return '';
        double runtime = ((this*multipler)/divisor);
        if(runtime < 60) return dot
            ? '\t•\t${runtime.floor()}m'
            : '${runtime.floor()}m';
        return dot 
            ? '\t•\t${(runtime/60).floor()}h ${(runtime-((runtime/60).floor()*60)).floor()}m'
            : '${(runtime/60).floor()}h ${(runtime-((runtime/60).floor()*60)).floor()}m';
    }

    // ignore: non_constant_identifier_names
    String lsTime_timestampString({ int divisor = 1, int multipler = 1 }) {
        if(this == null) return '';
        int seconds = ((this*multipler)/divisor).floor();
        int hours = 0;
        int minutes = 0;
        while(seconds >= 3600) {
            seconds -= 3600;
            hours++;
        }
        while(seconds >= 60) {
            seconds -= 60;
            minutes++;
        }
        return '${hours.toString().padLeft(1, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }

    // ignore: non_constant_identifier_names
    String lsTime_durationString({ int divisor = 1, int multiplier = 1 }) {
        if(this == null) return '';
        int duration = ((this*multiplier)/divisor).floor();
        int days = (duration/DAY_IN_SECONDS).floor();
        if(days > 0) return days == 1 ? '1 Day' : '$days Days';
        int hours = (duration/HOUR_IN_SECONDS).floor();
        if(hours > 0) return hours == 1 ? '1 Hour' : '$hours Hours';
        int minutes = (duration/MINUTE_IN_SECONDS).floor();
        if(minutes > 0) return minutes == 1 ? '1 Minute' : '$minutes Minutes';
        return duration == 1 ? '1 Second' : '$duration Seconds';
    }
}