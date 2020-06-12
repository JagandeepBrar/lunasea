import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NZBGetLogData {
    int id;
    String kind;
    int time;
    String text;

    NZBGetLogData({
        @required this.id,
        @required this.kind,
        @required this.time,
        @required this.text,
    });

    String get timestamp {
        return DateFormat('MMMM dd, y - hh:mm:ss a').format(DateTime.fromMillisecondsSinceEpoch(time*1000));
    }
}
