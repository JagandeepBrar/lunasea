extension DoubleTimeExtension on double {
    // ignore: non_constant_identifier_names
    String lsTime_releaseAgeString() {
        if(this == null) return '';
        int days = (this/24).floor();
        if(this > 48) return days == 1 ? '1 Day Ago' : '$days Days Ago';
        return this == 1 ? '1 Hour Ago' : '${this.toStringAsFixed(1)} Hours Ago';
    }
}
