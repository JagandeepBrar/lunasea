import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';

extension DateTimeExtension on DateTime {
    //ignore: non_constant_identifier_names
    DateTime lsDateTime_floor() => DateTime(this.year, this.month, this.day);

    //ignore: non_constant_identifier_names
    String lsDateTime_ageString(DateTime date) {
        if(this == null || date == null) return 'Unknown';
        Duration diff = this.difference(date);
        if(diff.inDays >= 1) {
            return '${diff.inDays} ${diff.inDays == 1 ? 'Day' : 'Days'} Ago';
        } else if(diff.inHours >= 1) {
            return '${diff.inHours} ${diff.inHours == 1 ? 'Hour' : 'Hours'} Ago';
        } else if(diff.inMinutes >= 1) {
            return '${diff.inMinutes} ${diff.inMinutes == 1 ? 'Minute' : 'Minutes'} Ago';
        }
        return '${diff.inSeconds} ${diff.inSeconds == 1 ? 'Second' : 'Seconds'} Ago';
    }

    //ignore: non_constant_identifier_names
    String lsDateTime_upcomingString(DateTime date, { bool shouldLimit = true, int limit = 30 }) {
        if(this == null || date == null) return 'Unknown';
        Duration diff = date.difference(this);
        if(diff.inDays == 0) return 'Today';
        if(shouldLimit && diff.inDays > limit) return '';
        return 'In ${diff.inDays} ${diff.inDays == 1 ? "Day" : "Days"}';
    }

    /// Returns just the time as a String.
    /// 3 PM will return either as 15:00 (24 hour style) or 3:00 PM depending on the configured database option
    //ignore: non_constant_identifier_names
    String get lsDateTime_time => LunaSeaDatabaseValue.USE_24_HOUR_TIME.data
        ? DateFormat.Hm().format(this)
        : DateFormat.jm().format(this);
}
