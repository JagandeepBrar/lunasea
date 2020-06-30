import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSSubtitle extends StatelessWidget {
    final String text;
    final int maxLines;
    final bool darken;
    final bool centerText;
    
    LSSubtitle({
        @required this.text,
        this.maxLines = 1,
        this.darken = false,
        this.centerText = false,
    });


    @override
    Widget build(BuildContext context) => Text(
        text,
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: maxLines,
        textAlign: centerText
            ? TextAlign.center
            : TextAlign.start,
        style: TextStyle(
            color: darken ? Colors.white30 : Colors.white70,
            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
        ),
    );
}
