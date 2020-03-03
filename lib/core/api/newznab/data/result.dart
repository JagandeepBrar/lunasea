import 'package:flutter/material.dart';

class NewznabResultData {
    final String title;
    final String category;
    final int size;
    final String linkDownload;
    final String linkComments;
    final String date;

    NewznabResultData({
        @required this.title,
        @required this.category,
        @required this.size,
        @required this.linkComments,
        @required this.linkDownload,
        @required this.date,
    });
}