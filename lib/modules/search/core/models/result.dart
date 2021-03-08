import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:intl/intl.dart';

class NewznabResultData {
    String title;
    String category;
    int size;
    String linkDownload;
    String linkComments;
    String date;

    NewznabResultData({
        @required this.title,
        @required this.category,
        @required this.size,
        @required this.linkComments,
        @required this.linkDownload,
        @required this.date,
    });

    DateTime get dateObject {
        try {
            DateFormat _format = DateFormat("EEE, dd MMM yyyy hh:mm:ss");
            String _dateFixed = [
                date.substring(0, 3),
                '.',
                date.substring(3, 11),
                '.',
                date.substring(11, date.length),
            ].join();
            int _offset = int.tryParse(_dateFixed.substring(_dateFixed.length - 5));
            DateTime _date = _format.parseUtc(_dateFixed);
            if(_offset != null) _date = _date.add(Duration(hours: (-(_offset/100).round())));
            return _date.toLocal().isAfter(DateTime.now()) ? DateTime.now() : _date.toLocal();
        } catch (e) {}
        return null;
    }

    String get age => dateObject?.lunaAge ?? 'Unknown Age';

    int get posix => dateObject?.millisecondsSinceEpoch ?? 0;
}