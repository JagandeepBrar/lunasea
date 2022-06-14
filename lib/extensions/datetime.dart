extension DateTimeExtension on DateTime {
  DateTime floor() {
    return DateTime(this.year, this.month, this.day);
  }
}
