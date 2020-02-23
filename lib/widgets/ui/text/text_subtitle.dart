import 'package:flutter/material.dart';

class LSSubtitle extends StatelessWidget {
    final String text;
    final int maxLines;
    final bool darken;
    
    LSSubtitle({
        @required this.text,
        this.maxLines = 1,
        this.darken = false,
    });


    @override
    Widget build(BuildContext context) => Text(
        text,
        overflow: TextOverflow.fade,
        softWrap: false,
        maxLines: maxLines,
        style: TextStyle(
            color: darken ? Colors.white30 : Colors.white70,
            fontSize: 14.0,
        ),
    );
}
