import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSTitle extends StatelessWidget {
    final String text;
    final int maxLines;
    final bool darken;
    final bool centerText;
    final bool softWrap;

    LSTitle({
        @required this.text,
        this.maxLines = 1,
        this.softWrap = false,
        this.darken = false,
        this.centerText = false,
    });

    @override
    Widget build(BuildContext context) => Text(
        text,
        overflow: TextOverflow.fade,
        softWrap: softWrap,
        maxLines: maxLines,
        textAlign: centerText
            ? TextAlign.center
            : TextAlign.start,
        style: TextStyle(
            color: darken ? Colors.white30 : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: Constants.UI_FONT_SIZE_TITLE,
        ),
    );
}