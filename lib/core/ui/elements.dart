import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class Elements {
    Elements._();
    
    static Padding getHeader(String title) {
        return Padding(
            child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34.0,
                    color: Colors.white,
                ),
            ),
            padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
        );
    }

    static Text getTitle(String title, {int maxLines = 1, bool darken = false}) {
        return Text(
            title,
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

    static Text getSubtitle(String title, {bool preventOverflow: false, int maxLines = 1, bool darken = false}) {
        return preventOverflow ? (
            Text(
                title,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: maxLines,
                style: TextStyle(
                    color: darken ? Colors.white30 : Colors.white70,
                    fontSize: 14.0,
                ),
            )
        ) : (
              Text(
                title,
                style: TextStyle(
                    color: darken ? Colors.white30 : Colors.white70,
                    fontSize: 14.0,
                ),
            )
        );
    }

    static Icon getIcon(IconData icon, {Color color = Colors.white}) {
        return Icon(
            icon,
            color: color,
        );
    }

    static EdgeInsetsGeometry getCardMargin() {
        return EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0);
    }

    static EdgeInsetsGeometry getListViewPadding({bool extraBottom = false}) {
        if(extraBottom) {
            return EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 20.0);
        }
        return EdgeInsets.symmetric(vertical: 8.0);
    }

    static EdgeInsetsGeometry getContentPadding() {
        return EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0);
    }

    static Padding getDivider({double padding = 14.0}) {
        return Padding(
            child: Divider(
                color: Color(Constants.ACCENT_COLOR),
            ),
            padding: EdgeInsets.symmetric(horizontal: padding),
        );
    }

    static Row getButton(String text, Function onTapHandler, { Color backgroundColor, Color textColor = Colors.white} ) {
        return Row(
            children: <Widget>[
                Expanded(
                    child: Card(
                        child: ListTile(
                            title: Text(
                                text,
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                            ),
                            onTap: onTapHandler,
                        ),
                        color: backgroundColor == null ? Color(Constants.ACCENT_COLOR) : backgroundColor,
                        margin: getCardMargin(),
                        elevation: 4.0,
                    ),
                ),
            ],
        );
    }
}