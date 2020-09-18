import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSTableContent extends StatelessWidget {
    final String title;
    final String body;

    LSTableContent({
        Key key,
        @required this.title,
        @required this.body,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => Padding(
        child: Row(
            children: [
                Expanded(
                    child: Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: 2,
                ),
                Container(width: 16.0, height: 0.0),
                Expanded(
                    child: Text(
                        body,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: 5,
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    );
}