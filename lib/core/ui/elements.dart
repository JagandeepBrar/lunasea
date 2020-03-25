import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class Elements {
    Elements._();

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
                overflow: null,
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

    static void showSnackBar(GlobalKey<ScaffoldState> key, String message, {int duration = 1500}) {
        Duration snackBarDuration = Duration(milliseconds: duration);
        key?.currentState?.showSnackBar(
            SnackBar(
                content: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: Constants.UI_LETTER_SPACING,
                    ),
                ),
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                duration: snackBarDuration,
                elevation: 2.0,
            )
        );
    }
}