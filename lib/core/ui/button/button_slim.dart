import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSButtonSlim extends StatelessWidget {
    final String text;
    final Function onTap;
    final Color backgroundColor;
    final Color textColor;
    final EdgeInsets margin;

    LSButtonSlim({
        @required this.text,
        @required this.onTap,
        this.backgroundColor = const Color(Constants.ACCENT_COLOR),
        this.textColor = Colors.white,
        this.margin = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
    });

    @override
    Widget build(BuildContext context) => Row(
        children: <Widget>[
            Expanded(
                child: Card(
                    child: InkWell(
                        child: Padding(
                            child: Text(
                                text,
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                ),
                                textAlign: TextAlign.center,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.0),
                        ),
                        onTap: onTap,
                    ),
                    color: backgroundColor,
                    margin: margin,
                    elevation: Constants.UI_ELEVATION,
                    shape: LSRoundedShape(),
                ),
            ),
        ],
    );
}