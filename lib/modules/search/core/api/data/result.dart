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
    DateTime _now = DateTime.now();

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
            int _offset = int.tryParse(date.substring(date.length - 5));
            DateTime _date = _format.parseUtc(date);
            if(_offset != null) _date = _date.add(Duration(hours: (-(_offset/100).round())));
            return _date.toLocal();
        } catch (e) {}
        return null;
    }

    String get age {
        DateTime _date = dateObject;
        return _date == null
            ? 'Unknown Age'
            : _now.lsDateTime_ageString(_date);
    }

    int get posix => dateObject?.millisecondsSinceEpoch ?? 0;
}