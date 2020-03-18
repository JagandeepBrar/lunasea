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
}
