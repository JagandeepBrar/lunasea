import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSTableContent extends StatelessWidget {
    final String title;
    final String body;
    final TextAlign titleAlign;
    final TextAlign bodyAlign;
    final int titleFlex;
    final int bodyFlex;
    final EdgeInsets padding;
    final Color titleColour;
    final Color bodyColour;

    LSTableContent({
        Key key,
        @required this.title,
        @required this.body,
        this.titleAlign = TextAlign.end,
        this.bodyAlign = TextAlign.start,
        this.titleFlex = 2,
        this.bodyFlex = 5,
        this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        this.titleColour = Colors.white70,
        this.bodyColour = Colors.white,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => Padding(
        child: Row(
            children: [
                Expanded(
                    child: Text(
                        title.toUpperCase(),
                        textAlign: titleAlign,
                        style: TextStyle(
                            color: titleColour,
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: titleFlex,
                ),
                Container(width: 16.0, height: 0.0),
                Expanded(
                    child: Text(
                        body,
                        textAlign: bodyAlign,
                        style: TextStyle(
                            color: bodyColour,
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: bodyFlex,
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: padding,
    );
}