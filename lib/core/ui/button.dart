import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';

class LSButton extends StatelessWidget {
    final String text;
    final Function onTap;
    final Color backgroundColor;
    final Color textColor;
    final bool reducedMargin;

    LSButton({
        @required this.text,
        @required this.onTap,
        this.backgroundColor = const Color(Constants.ACCENT_COLOR),
        this.textColor = Colors.white,
        this.reducedMargin = false,
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
                    margin: reducedMargin
                        ? EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0)
                        : Constants.UI_CARD_MARGIN,
                    elevation: Constants.UI_ELEVATION,
                ),
            ),
        ],
    );
}