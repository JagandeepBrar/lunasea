import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';

extension DateTimeExtension on DateTime {
    /// Get the floor of a date.
    /// 
    /// The floor is a new [DateTime] object with only the year, month, and day copied from the original source.
    DateTime get lunaFloor => DateTime(this.year, this.month, this.day);

    /// Returns a string representation of the "age" of the [DateTime] object.
    /// 
    /// Compares to [DateTime.now().toLocal()] to calculate the age.
    String get lunaAge {
        if(this == null) return 'Unknown';
        Duration diff = DateTime.now().toLocal().difference(this);
        if(diff.inDays >= 1) return '${diff.inDays} ${diff.inDays == 1 ? 'Day' : 'Days'} Ago';
        if(diff.inHours >= 1) return '${diff.inHours} ${diff.inHours == 1 ? 'Hour' : 'Hours'} Ago';
        if(diff.inMinutes >= 1) return '${diff.inMinutes} ${diff.inMinutes == 1 ? 'Minute' : 'Minutes'} Ago';
        return '${diff.inSeconds} ${diff.inSeconds == 1 ? 'Second' : 'Seconds'} Ago';
    }

    /// Returns a string representation of the difference in days/months/years.
    /// 
    /// Compares to [DateTime.now()] to calculate the difference.
    String get lunaDaysDifference {
        if(this == null) return Constants.TEXT_EMDASH;
        Duration diff = this.difference(DateTime.now());
        int absoluteDays = diff.inDays.abs();
        if(absoluteDays == 0) return 'Today';
        // If greater than 2 years, show in years
        if(absoluteDays >= 365*2) return '${(absoluteDays/365).round()} Years';
        // If greater than 3 months, show in months
        if(absoluteDays >= 30*3) return '${(absoluteDays/30).round()} Months';
        return '$absoluteDays ${absoluteDays == 1 ? "Day" : "Days"}';
    }

    /// Returns just the time as a string.
    /// 
    /// 3 PM will return either 15:00 (24 hour style) or 3:00 PM depending on the configured database option.
    String get lunaTime => LunaDatabaseValue.USE_24_HOUR_TIME.data ? DateFormat.Hm().format(this) : DateFormat.jm().format(this);

    /// Returns just the date as a string.
    /// 
    /// Formatted as YYYY-MM-DD
    String get lunaDate => '${this.year.toString().padLeft(4, '0')}-${this.month.toString().padLeft(2, '0')}-${this.day.toString().padLeft(2, '0')}';
}
