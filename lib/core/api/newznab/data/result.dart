import 'package:flutter/material.dart';

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
}