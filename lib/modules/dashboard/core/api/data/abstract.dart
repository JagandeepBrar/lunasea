import 'package:flutter/material.dart';

abstract class CalendarData {
  int id;
  String title;

  TextSpan get subtitle;
  String get bannerURI;
  Widget trailing(BuildContext context);
  Future<void> enterContent(BuildContext context);
  Future<void> trailingOnPress(BuildContext context);
  Future<void> trailingOnLongPress(BuildContext context);

  CalendarData(
    this.id,
    this.title,
  );
}
