import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSTextHighlighted extends StatelessWidget {
    final Color bgColor;
    final Color fgColor;
    final String text;
    final EdgeInsets margin;

    LSTextHighlighted({
        @required this.text,
        this.bgColor = const Color(Constants.ACCENT_COLOR),
        this.fgColor = Colors.white,
        this.margin = const EdgeInsets.only(right: 8.0),
    });

    @override
    Widget build(BuildContext context) => Padding(
        child: Container(
            child: Padding(
                child: Text(
                    text,
                    style: TextStyle(
                        fontSize: Constants.UI_FONT_SIZE_SUBHEADER,
                        color: fgColor,
                        fontWeight: FontWeight.w600,
                    ),
                ),
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            ),
            
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            ),
        ),
        padding: margin,
    );
}
