import 'package:flutter/material.dart';

class LSTitle extends StatelessWidget {
    final String text;
    final int maxLines;
    final bool darken;

    LSTitle({
        @required this.text,
        this.maxLines = 1,
        this.darken = false,
    });

    @override
    Widget build(BuildContext context) {
        return Text(
            text,
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: maxLines,
            style: TextStyle(
                color: darken ? Colors.white30 : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
            ),
        );
    }
}

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
    Widget build(BuildContext context) {
        return Text(
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
}
