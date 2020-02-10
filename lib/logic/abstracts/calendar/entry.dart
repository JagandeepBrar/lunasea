import 'package:flutter/material.dart';
import 'package:lunasea/logic/abstracts.dart';

abstract class CalendarEntry implements Entry {
    int id;
    String title;

    TextSpan get subtitle;
    String get bannerURI;
    Future<void> enterContent(BuildContext context);

    CalendarEntry(
        this.id,
        this.title,
    );
}
