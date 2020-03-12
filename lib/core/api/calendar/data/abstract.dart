import 'package:flutter/material.dart';

abstract class CalendarEntry {
    int id;
    String title;

    TextSpan get subtitle;
    IconButton get trailing;
    String get bannerURI;
    Future<void> enterContent(BuildContext context);

    CalendarEntry(
        this.id,
        this.title,
    );
}
