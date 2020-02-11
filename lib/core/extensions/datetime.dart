extension DateTimeExtension on DateTime {
    DateTime round() {
        return DateTime(this.year, this.month, this.day);
    }
}
