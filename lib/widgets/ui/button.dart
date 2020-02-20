import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';

class LSButton extends StatelessWidget {
    final String text;
    final Function onTap;
    final Color backgroundColor;
    final Color textColor;

    LSButton({
        @required this.text,
        @required this.onTap,
        this.backgroundColor = const Color(Constants.ACCENT_COLOR),
        this.textColor = Colors.white,
    });

    @override
    Widget build(BuildContext context) => Row(
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
                        onTap: onTap,
                    ),
                    color: backgroundColor,
                    margin: Constants.UI_CARD_MARGIN,
                    elevation: Constants.UI_ELEVATION,
                ),
            ),
        ],
    );
}