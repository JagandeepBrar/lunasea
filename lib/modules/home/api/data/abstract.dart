import 'package:flutter/material.dart';

abstract class CalendarData {
    int id;
    String title;

    TextSpan get subtitle;
    Widget get trailing;
    String get bannerURI;
    Future<void> enterContent(BuildContext context);

    CalendarData(
        this.id,
        this.title,
    );
}
